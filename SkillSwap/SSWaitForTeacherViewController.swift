//
//  SSWaitForTeacherViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/30/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import DynamicButton
import PopupDialog
import MessageUI

class SSWaitForTeacherViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    let waitingBar = UIView()
    let matchedBar = UIView()
    let timeExpire = UILabel()
    let color = SSColors.SSBlue
    var timer = Timer()
    var popup: PopupDialog = PopupDialog(title: "", message: "")
    let teacherNameLabel = UILabel()
    
    var time = 60 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpNotifications()
        
        layoutWaitingBar()
        layoutMatchedBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (SSCurrentUser.sharedInstance.learningStatus == .waiting) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
            time = Int((SSCurrentUser.sharedInstance.currentMeetupPost?.createdDate?.timeIntervalSince1970)!/1000 + 60*60 - Date().timeIntervalSince1970)
        }
        updateBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        time = Int((SSCurrentUser.sharedInstance.currentMeetupPost?.createdDate?.timeIntervalSince1970)! + 60*60 - Date().timeIntervalSince1970)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    private func setUpNotifications() {
        let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SSWaitForTeacherViewController.updateBar), name: notificationName, object: nil)
        
        let notificationName1 = Notification.Name(LEARNING_ACCEPTED_NOTIFICATION)
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SSWaitForTeacherViewController.checkMeetup), name: notificationName1, object: nil)
    }
    
    func layoutWaitingBar() {
        view.addSubview(waitingBar)
        waitingBar.backgroundColor = .white
        waitingBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        let titleView = UILabel()
        waitingBar.addSubview(titleView)
        titleView.text = "looking for help"
        titleView.font = UIFont(name: "Gotham-Book", size: 20)
        titleView.textColor = color
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        let iconView = UIImageView(image: #imageLiteral(resourceName: "people_image"))
        view.addSubview(iconView)
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(20)
        }
        
        let timeExpireTitle = UILabel()
        waitingBar.addSubview(timeExpireTitle)
        timeExpireTitle.text = "expires in"
        timeExpireTitle.font = UIFont(name: "Gotham-Book", size: 14)
        timeExpireTitle.textColor = SSColors.SSGray
        timeExpireTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        
        waitingBar.addSubview(timeExpire)
        timeExpire.text = "60:00"
        timeExpire.font = UIFont(name: "Gotham-Book", size: 28)
        timeExpire.textColor = color
        timeExpire.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeExpireTitle.snp.bottom).offset(0)
        }
        
        let button = UIButton()
        button.setTitle("See Post", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont(name: "Gotham-Medium", size: 18)
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(seePostSelected), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints({ (make) in
            make.top.equalTo(timeExpire.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        })
        
        let cancelButton = DynamicButton(style: DynamicButtonStyle.circleClose)
        waitingBar.addSubview(cancelButton)
        cancelButton.lineWidth = 3
        cancelButton.strokeColor = color
        cancelButton.highlightStokeColor = .gray
        cancelButton.addTarget(self, action: #selector(cancelPost), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
    }
    
    func countDown() {
        time = Int((SSCurrentUser.sharedInstance.currentMeetupPost?.createdDate?.timeIntervalSince1970)!/1000 + 60*60 - Date().timeIntervalSince1970)
        if time == 0 {
            timer.invalidate()
            SSCurrentUser.sharedInstance.learningStatus = .none
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
            
            let popup = PopupDialog(title: "Sorry 🙁", message: "There were no tutors available for you.")
            let buttonOne = CancelButton(title: "dimiss") {}
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        let sec = time % 60
        if sec < 10 {
            timeExpire.text = "\(time/60):0\(time % 60)"
        } else {
            timeExpire.text = "\(time/60):\(time % 60)"
        }
//        time -= 1
    }
    
    func checkMeetup () {
        SSDatabase.checkMeetup(meetup: SSCurrentUser.sharedInstance.currentMeetupPost!, completion: { (success, state) in
            if state == nil {
                return
            }
            if state! == MeetupState.matched {
                self.timer.invalidate()
                self.time = 0
                SSCurrentUser.sharedInstance.learningStatus = .matched
                
                let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
                NotificationCenter.default.post(name: notificationName, object: nil)
            } else if state! == MeetupState.expired {
                self.timer.invalidate()
                self.time = 0
                SSCurrentUser.sharedInstance.learningStatus = .none
                
                let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
                NotificationCenter.default.post(name: notificationName, object: nil)
                
                let popup = PopupDialog(title: "Sorry 🙁", message: "There were no tutors available for you.")
                let buttonOne = CancelButton(title: "dimiss") {}
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        })
    }
    
    func seePostSelected(){
        showPostDetailView()
    }
    
    func cancelPost() {
        let popup = PopupDialog(title: "Are you sure?", message: "If you cancel this you will delete your post.")
        let buttonOne = CancelButton(title: "dimiss") {}
        let buttonTwo = PopupDialogButton(title: "Yes, I'm sure") {
            SSDatabase.cancelMeetup(completion: { (success) in
                SSCurrentUser.sharedInstance.learningStatus = .none
                
                let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
                NotificationCenter.default.post(name: notificationName, object: nil)
            })
        }
        popup.addButtons([buttonOne, buttonTwo])
        self.present(popup, animated: true, completion: nil)
    }
    
    func layoutMatchedBar() {
        view.addSubview(matchedBar)
        matchedBar.backgroundColor = .white
        matchedBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        let topView = UIView()
        topView.backgroundColor = color
        matchedBar.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(view.frame.size.height * 0.35)
        }
        
        let titleView = UILabel()
        topView.addSubview(titleView)
        titleView.text = "Found Help!"
        titleView.font = UIFont(name: "Gotham-Book", size: 20)
        titleView.textColor = .white
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        let iconView = UIImageView(image: #imageLiteral(resourceName: "profile_sub_image"))
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .white
        topView.addSubview(iconView)
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.width.height.equalTo(80)
        }
        
        matchedBar.addSubview(teacherNameLabel)
        teacherNameLabel.text = SSCurrentUser.sharedInstance.currentMeetupPost?.teacher?.name!
        teacherNameLabel.font = UIFont(name: "Gotham-Book", size: 14)
        teacherNameLabel.textColor = .white
        teacherNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        
        let messageButton = UIButton()
        messageButton.setTitle("message", for: .normal)
        messageButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        messageButton.setTitleColor(SSColors.SSDarkGray, for: .normal)
        messageButton.addTarget(self, action: #selector(sendMessageButtonPressed), for: .touchUpInside)
        matchedBar.addSubview(messageButton)
        messageButton.snp.makeConstraints({ (make) in
            make.top.equalTo(topView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        })
        
        var line = UIView()
        matchedBar.addSubview(line)
        line.backgroundColor = SSColors.SSLightGray
        line.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(1)
            make.bottom.equalTo(messageButton)
            make.centerX.equalToSuperview()
        }
        
//        let messageIcon = UIImageView(image: #imageLiteral(resourceName: "chat_icon").withRenderingMode(.alwaysTemplate))
//        messageIcon.tintColor = SSColors.SSDarkGray
//        matchedBar.addSubview(messageIcon)
//        messageIcon.snp.makeConstraints { (make) in
//            make.centerY.equalTo(messageButton)
//            make.left.equalTo(line)
//            make.width.height.equalTo(15)
//        }
        
        let viewPostButton = UIButton()
        viewPostButton.setTitle("see post", for: .normal)
        viewPostButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        viewPostButton.setTitleColor(SSColors.SSDarkGray, for: .normal)
        viewPostButton.addTarget(self, action: #selector(seePostSelected), for: .touchUpInside)
        matchedBar.addSubview(viewPostButton)
        viewPostButton.snp.makeConstraints({ (make) in
            make.top.equalTo(messageButton.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        })
        
        line = UIView()
        matchedBar.addSubview(line)
        line.backgroundColor = SSColors.SSLightGray
        line.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(1)
            make.bottom.equalTo(viewPostButton)
            make.centerX.equalToSuperview()
        }
        
        let reportButton = UIButton()
        reportButton.setTitle("report", for: .normal)
        reportButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        reportButton.setTitleColor(SSColors.SSPink, for: .normal)
        reportButton.addTarget(self, action: #selector(layoutReportPopup), for: .touchUpInside)
        matchedBar.addSubview(reportButton)
        reportButton.snp.makeConstraints({ (make) in
            make.top.equalTo(viewPostButton.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        })
        
        line = UIView()
        matchedBar.addSubview(line)
        line.backgroundColor = SSColors.SSLightGray
        line.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(1)
            make.bottom.equalTo(reportButton)
            make.centerX.equalToSuperview()
        }
        
        let finishButton = UIButton()
        finishButton.setTitle("end session", for: .normal)
        finishButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 16)
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.backgroundColor = color
        finishButton.layer.cornerRadius = 4
        finishButton.addTarget(self, action: #selector(finishButtonSelected), for: .touchUpInside)
        matchedBar.addSubview(finishButton)
        finishButton.snp.makeConstraints({ (make) in
            make.top.equalTo(reportButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
        })
    }
    
    func layoutPaymentPopup(){
        let title = "Finish + Pay"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: "", image: #imageLiteral(resourceName: "money_transfer"))
        
        // Create buttons
        let buttonOne = CancelButton(title: "Cancel") {
            print("You canceled the car dialog.")
        }
        
        let time = SSCurrentUser.sharedInstance.currentMeetupPost?.timeExchange!
        let buttonTwo = DefaultButton(title: "😃 Pay") {
            self.layoutAdjustPayment()
        }
        
        let buttonFour = DefaultButton(title: "🙁 We never met", height: 60) {
            SSCurrentUser.sharedInstance.learningStatus = .none
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        popup.addButtons([buttonOne, buttonTwo, buttonFour])
        self.present(popup, animated: true, completion: nil)
    }
    
    func layoutAdjustPayment () {
        // Create the dialog
        let time = SSCurrentUser.sharedInstance.currentMeetupPost?.timeExchange!
        let adjustVC = SSAdjustPayViewController()
        adjustVC.minTime = time!
        let popup = PopupDialog(viewController: adjustVC)
        
        // Create buttons
        let buttonOne = CancelButton(title: "Cancel") {

        }
        
        let buttonTwo = DefaultButton(title: "Confirm Payment") {
            
            SSDatabase.payMeetup(exchange: adjustVC.numMinutes, meetup: SSCurrentUser.sharedInstance.currentMeetupPost!, completion: { (success) in
                SSCurrentUser.sharedInstance.learningStatus = .none
                
                let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
                NotificationCenter.default.post(name: notificationName, object: nil)
            })
            
        }
        
        popup.addButtons([buttonOne, buttonTwo])
        self.present(popup, animated: true, completion: nil)
    }
    
    func layoutReportPopup(){
        let title = "We are very sorry!"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: nil)
        
        // Create buttons
        let buttonOne = CancelButton(title: "Cancel") {
            print("You canceled the car dialog.")
        }
        
        let buttonTwo = DefaultButton(title: "Bad tutor") {
            SSCurrentUser.sharedInstance.learningStatus = .none
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        let buttonFour = DefaultButton(title: "🙁 We never met", height: 60) {
            SSCurrentUser.sharedInstance.learningStatus = .none
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        popup.addButtons([buttonOne, buttonTwo, buttonFour])
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func showPostDetailView(){
        
        let vc = SSTeachDetailViewController()
        vc.meetup = SSCurrentUser.sharedInstance.currentMeetupPost
        
        // Create the dialog
        let popup = PopupDialog(viewController: vc, buttonAlignment: UILayoutConstraintAxis.vertical, transitionStyle: .fadeIn, gestureDismissal: true, completion: nil)
        
        // Create buttons
        let buttonOne = CancelButton(title: "Dismiss") {
            popup.dismiss()
        }
    
        popup.addButtons([buttonOne])
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func finishButtonSelected(button :UIButton) {
        
        SSAnimations().popAnimateButton(button: button)
        
        layoutPaymentPopup()
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func updateBar(){
        matchedBar.isHidden = SSCurrentUser.sharedInstance.learningStatus == .waiting
        waitingBar.isHidden = SSCurrentUser.sharedInstance.learningStatus != .waiting
        teacherNameLabel.text = SSCurrentUser.sharedInstance.currentMeetupPost?.teacher?.name!
    }
    
    func sendMessageButtonPressed () {
        if (MFMessageComposeViewController.canSendText()) {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.recipients = [(SSCurrentUser.sharedInstance.currentMeetupPost?.teacher?.phone!)!]
            composeVC.body = "Hello, \((SSCurrentUser.sharedInstance.currentMeetupPost?.teacher?.name!)!)! Thanks for accepting my help request on SkillSwap. Where can I meet you?"
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: false, completion: nil)
    }
}

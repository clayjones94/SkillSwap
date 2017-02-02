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

class SSWaitForTeacherViewController: UIViewController {

    let waitingBar = UIView()
    let matchedBar = UIView()
    let timeExpire = UILabel()
    let color = SSColors.SSBlue
    var timer = Timer()
    var popup: PopupDialog = PopupDialog(title: "", message: "")
    
    var time = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpNotifications()
        
        layoutWaitingBar()
        layoutMatchedBar()
        layoutPaymentPopup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateBar()
    }
    
    private func setUpNotifications() {
        let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SSWaitForTeacherViewController.updateBar), name: notificationName, object: nil)
    }
    
    func layoutWaitingBar() {
        view.addSubview(waitingBar)
        waitingBar.backgroundColor = color
        waitingBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        let titleView = UILabel()
        waitingBar.addSubview(titleView)
        titleView.text = "looking for help"
        titleView.font = UIFont(name: "Gotham-Book", size: 20)
        titleView.textColor = .white
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
        timeExpire.text = "0:00"
        timeExpire.font = UIFont(name: "Gotham-Book", size: 28)
        timeExpire.textColor = .white
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
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
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
        cancelButton.strokeColor = .white
        cancelButton.highlightStokeColor = .gray
        cancelButton.addTarget(self, action: #selector(cancelPost), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
    }
    
    func countDown() {
        timeExpire.text = "\(time/60):\(time % 60)"
        time -= 1
        if time == 290 {
            SSCurrentUser.sharedInstance.learningStatus = .matched
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
    }
    
    func seePostSelected(){
        
    }
    
    func cancelPost() {
        SSCurrentUser.sharedInstance.learningStatus = .none
        
        let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
        NotificationCenter.default.post(name: notificationName, object: nil)
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
        
        let iconView = UIImageView(image: #imageLiteral(resourceName: "people_image"))
        topView.addSubview(iconView)
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.width.height.equalTo(80)
        }
        
        let nameLabel = UILabel()
        matchedBar.addSubview(nameLabel)
        nameLabel.text = "Clay Jones"
        nameLabel.font = UIFont(name: "Gotham-Book", size: 14)
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        
        let messageButton = UIButton()
        messageButton.setTitle("message", for: .normal)
        messageButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        messageButton.setTitleColor(SSColors.SSDarkGray, for: .normal)
        messageButton.addTarget(self, action: #selector(seePostSelected), for: .touchUpInside)
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
        reportButton.addTarget(self, action: #selector(seePostSelected), for: .touchUpInside)
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
        let message = "Pay your help"
        
        // Create the dialog
        popup = PopupDialog(title: title, message: message, image: #imageLiteral(resourceName: "money_transfer"))
        
        // Create buttons
        let buttonOne = CancelButton(title: "Cancel") {
            print("You canceled the car dialog.")
        }
        
        let buttonTwo = DefaultButton(title: "30 minutes") {
            SSCurrentUser.sharedInstance.learningStatus = .none
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        let buttonThree = DefaultButton(title: "40 minutes (Overtime)", height: 60) {
            SSCurrentUser.sharedInstance.learningStatus = .none
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        let buttonFour = DefaultButton(title: "0 minutes", height: 60) {
            SSCurrentUser.sharedInstance.learningStatus = .none
            
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        popup.addButtons([buttonOne, buttonTwo, buttonThree, buttonFour])
    }
    
    func finishButtonSelected(button :UIButton) {
        
        SSAnimations().popAnimateButton(button: button)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func updateBar(){
        matchedBar.isHidden = SSCurrentUser.sharedInstance.learningStatus == .waiting
        waitingBar.isHidden = SSCurrentUser.sharedInstance.learningStatus != .waiting
    }
}

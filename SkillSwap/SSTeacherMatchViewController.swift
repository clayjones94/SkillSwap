//
//  SSTeacherMatchViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/2/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import MessageUI

class SSTeacherMatchViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var meetup: SSMeetup?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color1 = hexStringToUIColor(hex: "00A0EA")
        let color2 = hexStringToUIColor(hex: "91DCFF")
        view.backgroundColor = UIColor.init(gradientStyle: .topToBottom, withFrame: view.frame, andColors: [color2, color1])
        
        layoutViews()
    }
    
    func layoutViews() {
        let titleView = UILabel()
        view.addSubview(titleView)
        titleView.text = "You've been matched with your student"
        titleView.font = UIFont(name: "Gotham-Book", size: 16)
        titleView.textColor = .white
        titleView.numberOfLines = 0
        titleView.textAlignment = .center
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(200)
        }
        
        let iconView = UIImageView(image: #imageLiteral(resourceName: "profile_sub_image"))
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .white
        view.addSubview(iconView)
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.width.height.equalTo(80)
        }
        
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.text = meetup?.student?.name!
        nameLabel.font = UIFont(name: "Gotham-Book", size: 14)
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        
        let messageButton = UIButton()
        messageButton.setTitle("message", for: .normal)
        messageButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        messageButton.setTitleColor(SSColors.SSBlue, for: .normal)
        messageButton.layer.cornerRadius = 4
        messageButton.backgroundColor = .white
        messageButton.addTarget(self, action: #selector(sendMessageButtonPressed), for: .touchUpInside)
        view.addSubview(messageButton)
        messageButton.snp.makeConstraints({ (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        })
        
        let instructionsLabel = UILabel()
        view.addSubview(instructionsLabel)
        instructionsLabel.text = "After you have taught your lesson, your match will pay you in time."
        instructionsLabel.font = UIFont(name: "Gotham-Book", size: 12)
        instructionsLabel.textColor = .white
        instructionsLabel.textAlignment = .center
        instructionsLabel.numberOfLines = 0
        instructionsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(messageButton.snp.bottom).offset(30)
            make.width.equalTo(200)
        }

        let timeIconView = UIImageView(image: #imageLiteral(resourceName: "time_transfer"))
        view.addSubview(timeIconView)
        timeIconView.sizeToFit()
        timeIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(instructionsLabel.snp.bottom).offset(20)
            make.width.equalToSuperview()
        }
        
        let dismissButton = UIButton()
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        dismissButton.setTitleColor(SSColors.SSBlue, for: .normal)
        dismissButton.layer.cornerRadius = 4
        dismissButton.backgroundColor = .white
        dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        })
    }
    
    func message() {
        
    }
    
    func sendMessageButtonPressed () {
        if (MFMessageComposeViewController.canSendText()) {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.recipients = [(meetup?.student?.phone!)!]
            composeVC.body = "Hello, \((meetup?.student?.name!)!) It's your tutor from SkillSwap. Where can I meet you?"
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func dismissButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}

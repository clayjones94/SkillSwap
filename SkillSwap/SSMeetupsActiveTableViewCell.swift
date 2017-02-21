//
//  SSMeetupsActiveTableViewCell.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/1/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import MessageUI

class SSMeetupsActiveTableViewCell: UITableViewCell, MFMessageComposeViewControllerDelegate {
    
    let iconView = UIImageView()
    let nameLabel = UILabel()
    let summaryLabel = UILabel()
    let timeLabel = UILabel()
    let paidLabel = UILabel()
    let line = UIView()
    let messageLabel = UILabel()
    //let messageIcon = UIImageView()
    var meetup: SSMeetup?
    
    override func layoutSubviews() {
        
        addSubview(iconView)
        iconView.image = #imageLiteral(resourceName: "profile_sub_image")
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = SSColors.SSGray
        iconView.layer.cornerRadius = (self.frame.size.height - 40)/2
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(self.snp.height).offset(-40)
        }

        
        addSubview(summaryLabel)
        let summary = meetup?.summary!
        let time = meetup?.timeExchange
        summaryLabel.text = "\(summary!) - \(time!) min"
        summaryLabel.font = UIFont(name: "Gotham-Book", size: 12)
        summaryLabel.textColor = SSColors.SSDarkGray
        summaryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        addSubview(nameLabel)
        nameLabel.text = meetup?.student?.name!
        nameLabel.font = UIFont(name: "Gotham-Book", size: 16)
        nameLabel.textColor = SSColors.SSDarkGray
        nameLabel.sizeToFit()
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(summaryLabel)
            make.bottom.equalTo(summaryLabel.snp.top).offset(-5)
        }
        
//        addSubview(messageIcon)
//        messageIcon.image = #imageLiteral(resourceName: "chat_icon")
//        messageIcon.image = messageIcon.image!.withRenderingMode(.alwaysTemplate)
//        messageIcon.tintColor = SSColors.SSBlue
//        messageIcon.layer.cornerRadius = (self.frame.size.height - 40)/2
//        iconView.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(10)
//            make.top.equalToSuperview().offset(20)
//            make.bottom.equalToSuperview().offset(-20)
//            make.width.equalTo(self.snp.height).offset(-40)
//        }
        
        addSubview(messageLabel)
        messageLabel.text = "message"
        messageLabel.font = UIFont(name: "Gotham-Medium", size: 16)
        messageLabel.textColor = SSColors.SSBlue
        messageLabel.snp.makeConstraints({ (make) in
            //make.right.equalToSuperview().offset(-10)
            //make.top.equalTo(nameLabel.snp.top).offset(10)
            make.left.equalTo(summaryLabel)
            make.top.equalTo(summaryLabel.snp.bottom).offset(5)
        })
//
//        addSubview(timeLabel)
//        let time = meetup?.timeExchange!
//        timeLabel.text = "\(time!) minutes"
//        timeLabel.font = UIFont(name: "Gotham-Book", size: 10)
//        timeLabel.textColor = SSColors.SSDarkGray
//        timeLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(summaryLabel)
//            make.top.equalTo(summaryLabel.snp.bottom).offset(5)
//        }
        
        addSubview(line)
        line.backgroundColor = SSColors.SSLightGray
        line.snp.makeConstraints { (make) in
            make.left.equalTo(summaryLabel)
            make.height.equalTo(1)
            make.right.bottom.equalToSuperview()
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //self.dismiss(animated: false, completion: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

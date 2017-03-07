//
//  SSMeetupsActiveTableViewCell.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/1/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import MessageUI
import PopupDialog

protocol ActiveMeetupTableViewCellDelegate {
    func meetupCellDidSelectRemind(cell: SSMeetupsActiveTableViewCell)
    func meetupCellDidSelectMessage(cell: SSMeetupsActiveTableViewCell)
    func meetupCellDidSelectCancel(cell: SSMeetupsActiveTableViewCell)
    func meetupCellDidSelectInfo(cell: SSMeetupsActiveTableViewCell)
}

class SSMeetupsActiveTableViewCell: UITableViewCell {
    
    let iconView = UIImageView()
    let nameLabel = UILabel()
    let summaryLabel = UILabel()
    
    let requestButton = SSIconLabelButton(detail: "Request time", icon: #imageLiteral(resourceName: "request_button"))
    let messageButton = SSIconLabelButton(detail: "Message", icon: #imageLiteral(resourceName: "message_button"))
    let infoButton = SSIconLabelButton(detail: "Info", icon: #imageLiteral(resourceName: "info_button"))
    let cancelButton = SSIconLabelButton(detail: "Cancel", icon: #imageLiteral(resourceName: "cancel_button_icon"))
    
    let line = UIView()
    var meetup: SSMeetup?
    
    var delegate: ActiveMeetupTableViewCellDelegate?
    
    override func layoutSubviews() {
        
        addSubview(iconView)
        iconView.image = #imageLiteral(resourceName: "profile_sub_image")
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = SSColors.SSGray
        iconView.layer.cornerRadius = (self.frame.size.height - 40)/2
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        addSubview(nameLabel)
        nameLabel.text = meetup?.student?.name!
        nameLabel.font = UIFont(name: "Gotham-Medium", size: 16)
        nameLabel.textColor = SSColors.SSDarkGray
        nameLabel.sizeToFit()
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.bottom.equalTo(iconView.snp.centerY)
        }
        
        addSubview(summaryLabel)
        let summary = meetup?.summary!
        let time = meetup?.timeExchange
        summaryLabel.text = "\(summary!) - \(time!) min"
        summaryLabel.font = UIFont(name: "Gotham-Book", size: 12)
        summaryLabel.textColor = SSColors.SSDarkGray
        summaryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
        }
        
        addSubview(line)
        line.backgroundColor = SSColors.SSLightGray
        line.snp.makeConstraints { (make) in
            make.left.equalTo(summaryLabel)
            make.height.equalTo(1)
            make.right.bottom.equalToSuperview()
        }
        
        addSubview(requestButton)
        requestButton.addTarget(self, action: #selector(SSMeetupsActiveTableViewCell.request), for: .touchUpInside)
        requestButton.tintColor = hexStringToUIColor(hex: "#75DF98")
        requestButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.frame.size.width/5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(self.frame.size.width/5)
            make.height.equalTo(40)
        }
        
        addSubview(messageButton)
        messageButton.tintColor = hexStringToUIColor(hex: "#92D4F5")
        messageButton.addTarget(self, action: #selector(SSMeetupsActiveTableViewCell.message), for: .touchUpInside)
        messageButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.frame.size.width * 2/5)
            make.bottom.equalTo(requestButton)
            make.width.equalTo(self.frame.size.width/5)
            make.height.equalTo(40)
        }
        
        addSubview(infoButton)
        infoButton.tintColor = hexStringToUIColor(hex: "#FEDB8E")
        infoButton.addTarget(self, action: #selector(SSMeetupsActiveTableViewCell.info), for: .touchUpInside)
        infoButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.frame.size.width * 3/5)
            make.bottom.equalTo(requestButton)
            make.width.equalTo(self.frame.size.width/5)
            make.height.equalTo(40)
        }
        
        addSubview(cancelButton)
        cancelButton.tintColor = hexStringToUIColor(hex: "#EB6E7B")
        cancelButton.addTarget(self, action: #selector(SSMeetupsActiveTableViewCell.cancel), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.frame.size.width * 4/5)
            make.bottom.equalTo(requestButton)
            make.height.equalTo(40)
            make.width.equalTo(self.frame.size.width/5)
        }
    }
    
    func request() {
        SSAnimations().popAnimateButton(button: requestButton)
        delegate?.meetupCellDidSelectRemind(cell: self)
    }
    
    func message() {
        SSAnimations().popAnimateButton(button: messageButton)
        delegate?.meetupCellDidSelectMessage(cell: self)
    }
    
    func info() {
        SSAnimations().popAnimateButton(button: infoButton)
        delegate?.meetupCellDidSelectInfo(cell: self)
    }
    
    func cancel() {
        SSAnimations().popAnimateButton(button: cancelButton)
        delegate?.meetupCellDidSelectCancel(cell: self)
    }
}

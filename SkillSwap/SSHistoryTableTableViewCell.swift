//
//  SSHistoryTableViewCell.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/1/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSHistoryTableViewCell: UITableViewCell {
    
    let iconBackdrop = UIView()
    let iconView = UIImageView()
    let nameLabel = UILabel()
    let summaryLabel = UILabel()
    let timeLabel = UILabel()
    let paidLabel = UILabel()
    let line = UIView()
    var meetup: SSMeetup?
    
    override func layoutSubviews() {
        
        addSubview(iconBackdrop)
        iconBackdrop.backgroundColor = meetup?.topic?.subject?.color
        iconBackdrop.layer.cornerRadius = (self.frame.size.height - 40)/2
        iconBackdrop.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(self.snp.height).offset(-40)
        }
        
        iconBackdrop.addSubview(iconView)
        iconView.image = meetup?.topic?.subject?.image
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = detailColorForColor(color: (meetup?.topic?.subject?.color)!)
        //        iconView.backgroundColor = meetup?.topic?.subject?.color
        //        iconView.layer.cornerRadius = (self.frame.size.height - 40)/2
        iconView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview().offset(-25)
        }
        
        addSubview(summaryLabel)
        summaryLabel.text = meetup?.summary!
        summaryLabel.font = UIFont(name: "Gotham-Book", size: 12)
        summaryLabel.textColor = SSColors.SSGray
        summaryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconBackdrop.snp.right).offset(10)
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
        
        addSubview(timeLabel)
        let time = meetup?.timeExchange!
        timeLabel.text = "\(time!) minutes"
        timeLabel.font = UIFont(name: "Gotham-Book", size: 10)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(summaryLabel)
            make.top.equalTo(summaryLabel.snp.bottom).offset(5)
        }
        
        addSubview(paidLabel)
        //paidLabel.text = meetup?.state
        paidLabel.text = "paid"
        paidLabel.font = UIFont(name: "Gotham-Book", size: 10)
        paidLabel.textColor = SSColors.SSDarkGray
        paidLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.centerY.equalTo(timeLabel)
        }
        
        addSubview(line)
        line.backgroundColor = SSColors.SSLightGray
        line.snp.makeConstraints { (make) in
            make.left.equalTo(summaryLabel)
            make.height.equalTo(1)
            make.right.bottom.equalToSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}




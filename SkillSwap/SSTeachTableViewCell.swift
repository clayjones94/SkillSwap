//
//  SSTeachTableViewCell.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/1/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSTeachTableViewCell: UITableViewCell {

    let iconBackdrop = UIView()
    let iconView = UIImageView()
    let summaryLabel = UILabel()
    let subjectLabel = UILabel()
    let timeLabel = UILabel()
    let locationLabel = UILabel()
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
        
        addSubview(subjectLabel)
        let subject = meetup?.topic?.subject?.name!
        let topic = meetup?.topic?.name!
        subjectLabel.text = "\(subject!) - \(topic!)"
        subjectLabel.font = UIFont(name: "Gotham-Book", size: 12)
        subjectLabel.textColor = SSColors.SSGray
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconBackdrop.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        addSubview(summaryLabel)
        summaryLabel.text = meetup?.summary
        summaryLabel.font = UIFont(name: "Gotham-Book", size: 16)
        summaryLabel.textColor = SSColors.SSDarkGray
        summaryLabel.sizeToFit()
        summaryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.bottom.equalTo(subjectLabel.snp.top).offset(-5)
        }
        
        addSubview(timeLabel)
        let time = meetup?.timeExchange!
        timeLabel.text = "\(time!) minutes"
        timeLabel.font = UIFont(name: "Gotham-Book", size: 10)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.top.equalTo(subjectLabel.snp.bottom).offset(5)
        }
        
        addSubview(locationLabel)
        locationLabel.text = meetup?.location?.name
        locationLabel.font = UIFont(name: "Gotham-Book", size: 10)
        locationLabel.textColor = SSColors.SSDarkGray
        locationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(10)
            make.centerY.equalTo(timeLabel)
        }
        
        addSubview(line)
        line.backgroundColor = SSColors.SSLightGray
        line.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.height.equalTo(1)
            make.right.bottom.equalToSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

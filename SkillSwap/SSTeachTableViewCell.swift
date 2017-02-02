//
//  SSTeachTableViewCell.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/1/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSTeachTableViewCell: UITableViewCell {

    let iconView = UIImageView()
    let summaryLabel = UILabel()
    let subjectLabel = UILabel()
    let timeLabel = UILabel()
    let locationLabel = UILabel()
    let line = UIView()

    override func layoutSubviews() {
        addSubview(iconView)
        iconView.backgroundColor = SSColors.SSBlue
        iconView.layer.cornerRadius = (self.frame.size.height - 40)/2
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(self.snp.height).offset(-40)
        }
        
        addSubview(subjectLabel)
        subjectLabel.text = "Chemistry - Chem 31"
        subjectLabel.font = UIFont(name: "Gotham-Book", size: 12)
        subjectLabel.textColor = SSColors.SSGray
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        addSubview(summaryLabel)
        summaryLabel.text = "Need Help with PSet2"
        summaryLabel.font = UIFont(name: "Gotham-Book", size: 16)
        summaryLabel.textColor = SSColors.SSDarkGray
        summaryLabel.sizeToFit()
        summaryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.bottom.equalTo(subjectLabel.snp.top).offset(-5)
        }
        
        addSubview(timeLabel)
        timeLabel.text = "30 minutes"
        timeLabel.font = UIFont(name: "Gotham-Book", size: 10)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.top.equalTo(subjectLabel.snp.bottom).offset(5)
        }
        
        addSubview(locationLabel)
        locationLabel.text = "Green Library"
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

//
//  SSTeachDetailViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/2/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSTeachDetailViewController: UIViewController {
    
    let color = SSColors.SSBlue
    var meetup: SSMeetup?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.height.equalTo(380)
        }
        layoutSummary()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
    }
    
    func layoutSummary() {
        
        let iconView = UIImageView(image: #imageLiteral(resourceName: "profile_sub_image"))
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = SSColors.SSGray
        view.addSubview(iconView)
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
        }
        
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.text = meetup?.student?.name
        nameLabel.font = UIFont(name: "Gotham-Book", size: 14)
        nameLabel.textColor = SSColors.SSDarkGray
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        
        let summaryLabel = UILabel()
        view.addSubview(summaryLabel)
        summaryLabel.text = meetup?.summary
        summaryLabel.numberOfLines = 0
        summaryLabel.font = UIFont(name: "Gotham-Medium", size: 16)
        summaryLabel.textColor = SSColors.SSDarkGray
        summaryLabel.textAlignment = .center
        summaryLabel.sizeToFit()
        summaryLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
        }
        
        let subjectIconView = UIImageView(image: #imageLiteral(resourceName: "location_icon"))
        view.addSubview(subjectIconView)
        subjectIconView.sizeToFit()
        subjectIconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(summaryLabel.snp.bottom).offset(10)
        }
        subjectIconView.image = subjectIconView.image!.withRenderingMode(.alwaysTemplate)
        subjectIconView.tintColor = color
        
        let subjectLabel = UILabel()
        view.addSubview(subjectLabel)
        let subject = meetup?.topic?.subject?.name!
        let topic = meetup?.topic?.name!
        subjectLabel.text = "\(subject!) - \(topic!)"
        subjectLabel.font = UIFont(name: "Gotham-Book", size: 12)
        subjectLabel.textColor = SSColors.SSDarkGray
        subjectLabel.textAlignment = .center
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectIconView.snp.right).offset(10)
            make.centerY.equalTo(subjectIconView)
        }
        
        let locationIconView = UIImageView(image: #imageLiteral(resourceName: "location_icon"))
        view.addSubview(locationIconView)
        locationIconView.sizeToFit()
        locationIconView.snp.makeConstraints { (make) in
            make.left.equalTo(subjectIconView)
            make.top.equalTo(subjectIconView.snp.bottom).offset(5)
        }
        locationIconView.image = locationIconView.image!.withRenderingMode(.alwaysTemplate)
        locationIconView.tintColor = color
        
        let locationLabel = UILabel()
        view.addSubview(locationLabel)
        locationLabel.text = meetup?.location?.name
        locationLabel.font = UIFont(name: "Gotham-Book", size: 12)
        locationLabel.textColor = SSColors.SSDarkGray
        locationLabel.textAlignment = .center
        locationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.centerY.equalTo(locationIconView)
        }
        
        let timeIconView = UIImageView(image: #imageLiteral(resourceName: "time_icon"))
        view.addSubview(timeIconView)
        timeIconView.sizeToFit()
        timeIconView.snp.makeConstraints { (make) in
            make.left.equalTo(subjectIconView)
            make.top.equalTo(locationIconView.snp.bottom).offset(5)
        }
        timeIconView.image = timeIconView.image!.withRenderingMode(.alwaysTemplate)
        timeIconView.tintColor = color
        
        let timeLabel = UILabel()
        view.addSubview(timeLabel)
        let time = meetup?.timeExchange!
        timeLabel.text = "\(time!) minutes"
        timeLabel.font = UIFont(name: "Gotham-Book", size: 12)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.textAlignment = .center
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.centerY.equalTo(timeIconView)
        }
        
        let detailTitle = UILabel()
        view.addSubview(detailTitle)
        detailTitle.text = "Detail"
        detailTitle.font = UIFont(name: "Gotham-Medium", size: 12)
        detailTitle.textColor = color
        detailTitle.textAlignment = .center
        detailTitle.snp.makeConstraints { (make) in
            make.left.equalTo(subjectIconView)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
        
        let detailLabel = UILabel()
        view.addSubview(detailLabel)
        detailLabel.text = meetup?.details
        detailLabel.font = UIFont(name: "Gotham-Book", size: 12)
        detailLabel.textColor = SSColors.SSDarkGray
        detailLabel.textAlignment = .left
        detailLabel.numberOfLines = 0
        detailLabel.sizeToFit()
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(detailTitle)
            make.top.equalTo(detailTitle.snp.bottom).offset(3)
            make.width.equalTo(230)
        }
    }
}

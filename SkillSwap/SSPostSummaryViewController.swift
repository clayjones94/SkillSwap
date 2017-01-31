//
//  SSPostSummaryViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/30/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSPostSummaryViewController: UIViewController {
    
    let titleView = UILabel()
    var color = SSColors.SSGreen

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        layoutTopBar()
        layoutSummary()
    }
    
    
    func layoutTopBar () {
        view.addSubview(titleView)
        titleView.text = "Summary"
        titleView.font = UIFont(name: "Gotham-Medium", size: 18)
        titleView.textColor = color
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        let cancelButton = UIButton(type: .custom)
        let image = UIImage(named: "back_icon")?.withRenderingMode(.alwaysTemplate)
        cancelButton.setImage(image, for: .normal)
        cancelButton.tintColor = color
        cancelButton.sizeToFit()
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(backbuttonSelected), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(titleView)
        }
    }
    
    func layoutSummary () {
        let topLine = UIView()
        view.addSubview(topLine)
        topLine.backgroundColor = color.withAlphaComponent(0.5)
        topLine.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalTo(200)
        }
        
        let summaryLabel = UILabel()
        view.addSubview(summaryLabel)
        summaryLabel.text = "Need help with pset1"
        summaryLabel.font = UIFont(name: "Gotham-Medium", size: 18)
        summaryLabel.textColor = SSColors.SSDarkGray
        summaryLabel.textAlignment = .center
        summaryLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(topLine.snp.bottom).offset(30)
        }
        
        let detailTitle = UILabel()
        view.addSubview(detailTitle)
        detailTitle.text = "Detail"
        detailTitle.font = UIFont(name: "Gotham-Medium", size: 12)
        detailTitle.textColor = color
        detailTitle.textAlignment = .center
        detailTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(summaryLabel.snp.bottom).offset(20)
        }
        
        let detailLabel = UILabel()
        view.addSubview(detailLabel)
        detailLabel.text = "I’m working on my first pset of chem 31 and I need help with various introductory topics within organic chemistry."
        detailLabel.font = UIFont(name: "Gotham-Book", size: 12)
        detailLabel.textColor = SSColors.SSDarkGray
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        detailLabel.sizeToFit()
        detailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailTitle.snp.bottom).offset(3)
            make.width.equalTo(270)
        }
        
        let subjectTitle = UILabel()
        view.addSubview(subjectTitle)
        subjectTitle.text = "Subject - Focus"
        subjectTitle.font = UIFont(name: "Gotham-Medium", size: 12)
        subjectTitle.textColor = color
        subjectTitle.textAlignment = .center
        subjectTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
        }
        
        let subjectLabel = UILabel()
        view.addSubview(subjectLabel)
        subjectLabel.text = "Chemistry - Chem 31"
        subjectLabel.font = UIFont(name: "Gotham-Book", size: 12)
        subjectLabel.textColor = SSColors.SSDarkGray
        subjectLabel.textAlignment = .center
        subjectLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(subjectTitle.snp.bottom).offset(3)
        }
        
        let locationIconView = UIImageView(image: #imageLiteral(resourceName: "location_icon"))
        view.addSubview(locationIconView)
        locationIconView.sizeToFit()
        locationIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(subjectLabel.snp.bottom).offset(20)
        }
        locationIconView.image = locationIconView.image!.withRenderingMode(.alwaysTemplate)
        locationIconView.tintColor = color
        
        let locationLabel = UILabel()
        view.addSubview(locationLabel)
        locationLabel.text = "Tressider Union"
        locationLabel.font = UIFont(name: "Gotham-Book", size: 12)
        locationLabel.textColor = SSColors.SSDarkGray
        locationLabel.textAlignment = .center
        locationLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationIconView.snp.bottom).offset(3)
        }
        
        let timeIconView = UIImageView(image: #imageLiteral(resourceName: "time_icon"))
        view.addSubview(timeIconView)
        timeIconView.sizeToFit()
        timeIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
        }
        timeIconView.image = timeIconView.image!.withRenderingMode(.alwaysTemplate)
        timeIconView.tintColor = color
        
        let timeLabel = UILabel()
        view.addSubview(timeLabel)
        timeLabel.text = "30 minutes"
        timeLabel.font = UIFont(name: "Gotham-Book", size: 12)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.textAlignment = .center
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeIconView.snp.bottom).offset(3)
        }
        
        let bottomLine = UIView()
        view.addSubview(bottomLine)
        bottomLine.backgroundColor = color.withAlphaComponent(0.5)
        bottomLine.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalTo(200)
        }
        
        let postButton = UIButton(type: .roundedRect)
        view.addSubview(postButton)
        postButton.backgroundColor = .white
        postButton.setTitleColor(color, for: .normal)
        postButton.setTitle("POST", for: .normal)
        postButton.titleLabel?.font = UIFont(name: "Gotham-Medium", size: 16)
        postButton.layer.cornerRadius = 5
        postButton.layer.borderColor = color.cgColor
        postButton.layer.borderWidth = 2
        view.addSubview(postButton)
        postButton.addTarget(self, action: #selector(postButtonSelected), for: .touchUpInside)
        postButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomLine.snp.bottom).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
    }
    
    func postButtonSelected() {
        
    }

    func backbuttonSelected() {
        navigationController?.popViewController(animated: true)
    }
}

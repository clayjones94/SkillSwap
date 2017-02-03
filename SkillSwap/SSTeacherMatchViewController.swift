//
//  SSTeacherMatchViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/2/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSTeacherMatchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = SSColors.SSBlue
        
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
        
        let iconView = UIImageView(image: #imageLiteral(resourceName: "people_image"))
        view.addSubview(iconView)
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.width.height.equalTo(80)
        }
        
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.text = "Clay Jones"
        nameLabel.font = UIFont(name: "Gotham-Book", size: 14)
        nameLabel.textColor = .white
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        
        let messageButton = UIButton()
        messageButton.setTitle("send message", for: .normal)
        messageButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 12)
        messageButton.setTitleColor(SSColors.SSBlue, for: .normal)
        messageButton.layer.cornerRadius = 4
        messageButton.backgroundColor = .white
        messageButton.addTarget(self, action: #selector(message), for: .touchUpInside)
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
        dismissButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 12)
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
    
    func dismissButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}
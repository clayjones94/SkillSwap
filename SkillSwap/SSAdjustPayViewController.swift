//
//  SSAdjustPayViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import DynamicButton
import PopupDialog

class SSAdjustPayViewController: UIViewController {
    
    let titleView = UILabel()
    var color = SSColors.SSBlue
    let upButton = DynamicButton(style: DynamicButtonStyle.caretUp)
    let downButton = DynamicButton(style: DynamicButtonStyle.caretDown)
    let timeLabel = UILabel()
    var numMinutes = 0
    var minTime = 0
    let ownersMinutes = SSCurrentUser.sharedInstance.user?.time
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.snp.makeConstraints { (make) in
            make.width.equalTo(250)
            make.height.equalTo(340)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        numMinutes = minTime
        
        layoutTopBar()
        layoutTimeCounter()
    }
    
    
    func layoutTopBar () {
        view.addSubview(titleView)
        titleView.text = "How long was the session?"
        titleView.numberOfLines = 0
        titleView.textAlignment = .center
        titleView.font = UIFont(name: "Gotham-Medium", size: 18)
        titleView.textColor = color
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(150)
        }
        
        let myTimeLabel = UILabel()
        view.addSubview(myTimeLabel)
        myTimeLabel.text = "You have \(ownersMinutes!) minutes to spend."
        myTimeLabel.numberOfLines = 0
        myTimeLabel.textAlignment = .center
        myTimeLabel.font = UIFont(name: "Gotham-Book", size: 14)
        myTimeLabel.textColor = SSColors.SSDarkGray
        myTimeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view).offset(-15)
            make.width.equalTo(150)
        }
    }
    
    func layoutTimeCounter (){
        view.addSubview(upButton)
        upButton.lineWidth = 3
        upButton.strokeColor = color
        upButton.highlightStokeColor = .gray
        upButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(25)
            make.width.height.equalTo(50)
        }
        upButton.layer.borderWidth = 3
        upButton.layer.borderColor = color.cgColor
        upButton.layer.cornerRadius = 25
        upButton.addTarget(self, action: #selector(addTime), for: .touchUpInside)
        
        view.addSubview(timeLabel)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.font = UIFont(name: "Gotham-Book", size: 48)
        timeLabel.textAlignment = .center
        timeLabel.text = "\(numMinutes)"
        timeLabel.sizeToFit()
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(upButton.snp.bottom).offset(5)
        }
        
        let timeDetail = UILabel()
        view.addSubview(timeDetail)
        timeDetail.textColor = SSColors.SSGray
        timeDetail.font = UIFont(name: "Gotham-Book", size: 14)
        timeDetail.textAlignment = .center
        timeDetail.text = "Minutes"
        timeDetail.sizeToFit()
        timeDetail.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
        }
        
        view.addSubview(downButton)
        downButton.lineWidth = 3
        downButton.strokeColor = color
        downButton.highlightStokeColor = .gray
        downButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeDetail.snp.bottom).offset(10)
            make.width.height.equalTo(50)
        }
        downButton.layer.borderWidth = 3
        downButton.layer.borderColor = color.cgColor
        downButton.layer.cornerRadius = 25
        downButton.addTarget(self, action: #selector(removeTime), for: .touchUpInside)
        downButton.setStyle(DynamicButtonStyle.none, animated: false)
        downButton.isUserInteractionEnabled = false
    }
    
    func addTime() {
        if (numMinutes <= ownersMinutes! - 5) {
            numMinutes += 5
            updateTimeLabel()
        }
        
        if (numMinutes > ownersMinutes! - 5) {
            upButton.setStyle(DynamicButtonStyle.none, animated: false)
            upButton.isUserInteractionEnabled = false
        }
        
        if (numMinutes > minTime && downButton.style == DynamicButtonStyle.none){
            downButton.setStyle(DynamicButtonStyle.caretDown, animated: false)
            downButton.isUserInteractionEnabled = true
        }
        
    }
    
    func removeTime() {
        if (numMinutes >= 5) {
            numMinutes -= 5
            updateTimeLabel()
        }
        if (numMinutes == minTime){
            downButton.setStyle(DynamicButtonStyle.none, animated: false)
            downButton.isUserInteractionEnabled = false
        }
        
        if (numMinutes <= ownersMinutes! - 5 && upButton.style == DynamicButtonStyle.none) {
            upButton.setStyle(DynamicButtonStyle.caretUp, animated: false)
            upButton.isUserInteractionEnabled = true
        }
    }
    
    func updateTimeLabel(){
        timeLabel.text = "\(numMinutes)"
        timeLabel.sizeToFit()
    }
}

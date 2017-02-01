//
//  SSSelectTimeViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/30/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import DynamicButton

class SSSelectTimeViewController: UIViewController {
    
    let titleView = UILabel()
    var color = SSColors.SSBlue
    let upButton = DynamicButton(style: DynamicButtonStyle.caretUp)
    let downButton = DynamicButton(style: DynamicButtonStyle.caretDown)
    let timeLabel = UILabel()
    var numMinutes = 0
    let ownersMinutes = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layoutTopBar()
        layoutTimeCounter()
    }
    
    
    func layoutTopBar () {
        view.addSubview(titleView)
        titleView.text = "How long?"
        titleView.font = UIFont(name: "Gotham-Medium", size: 18)
        titleView.textColor = color
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        let myTimeLabel = UILabel()
        view.addSubview(myTimeLabel)
        myTimeLabel.text = "You have \n \(ownersMinutes) minutes \n to spend."
        myTimeLabel.numberOfLines = 0
        myTimeLabel.sizeToFit()
        myTimeLabel.textAlignment = .center
        myTimeLabel.font = UIFont(name: "Gotham-Book", size: 18)
        myTimeLabel.textColor = SSColors.SSDarkGray
        myTimeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view).offset(-55)
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
        
        let nextButton = UIButton(type: .custom)
        let nextimage = UIImage(named: "next_icon")?.withRenderingMode(.alwaysTemplate)
        nextButton.setImage(nextimage, for: .normal)
        nextButton.tintColor = color
        nextButton.sizeToFit()
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonSelected), for: .touchUpInside)
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(titleView)
        }
    }
    
    func layoutTimeCounter (){
        view.addSubview(upButton)
        upButton.lineWidth = 3
        upButton.strokeColor = color
        upButton.highlightStokeColor = .gray
        upButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(50)
            make.width.height.equalTo(80)
        }
        upButton.layer.borderWidth = 3
        upButton.layer.borderColor = color.cgColor
        upButton.layer.cornerRadius = 40
        upButton.addTarget(self, action: #selector(addTime), for: .touchUpInside)
        
        view.addSubview(timeLabel)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.font = UIFont(name: "Gotham-Book", size: 60)
        timeLabel.textAlignment = .center
        timeLabel.text = "\(numMinutes)"
        timeLabel.sizeToFit()
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(upButton.snp.bottom).offset(20)
        }
        
        let timeDetail = UILabel()
        view.addSubview(timeDetail)
        timeDetail.textColor = SSColors.SSGray
        timeDetail.font = UIFont(name: "Gotham-Book", size: 18)
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
            make.top.equalTo(timeDetail.snp.bottom).offset(20)
            make.width.height.equalTo(80)
        }
        downButton.layer.borderWidth = 3
        downButton.layer.borderColor = color.cgColor
        downButton.layer.cornerRadius = 40
        downButton.addTarget(self, action: #selector(removeTime), for: .touchUpInside)
    }
    
    func addTime() {
        if (numMinutes <= ownersMinutes - 5) {
            numMinutes += 5
            updateTimeLabel()
        }
        
        if (numMinutes > ownersMinutes - 5) {
            upButton.setStyle(DynamicButtonStyle.none, animated: false)
            upButton.isUserInteractionEnabled = false
        }
        
        if (numMinutes > 0 && downButton.style == DynamicButtonStyle.none){
            downButton.setStyle(DynamicButtonStyle.caretDown, animated: false)
            downButton.isUserInteractionEnabled = true
        }

    }
    
    func removeTime() {
        if (numMinutes >= 5) {
            numMinutes -= 5
            updateTimeLabel()
        }
        if (numMinutes == 0){
            downButton.setStyle(DynamicButtonStyle.none, animated: false)
            downButton.isUserInteractionEnabled = false
        }
        
        if (numMinutes <= ownersMinutes - 5 && upButton.style == DynamicButtonStyle.none) {
            upButton.setStyle(DynamicButtonStyle.caretUp, animated: false)
            upButton.isUserInteractionEnabled = true
        }
    }
    
    func updateTimeLabel(){
        timeLabel.text = "\(numMinutes)"
        timeLabel.sizeToFit()
    }
    
    func backbuttonSelected() {
        navigationController?.popViewController(animated: true)
    }
    
    func nextButtonSelected() {
        let vc = SSPostSummaryViewController()
        vc.color = color
        navigationController?.pushViewController(vc, animated: true)
    }
}

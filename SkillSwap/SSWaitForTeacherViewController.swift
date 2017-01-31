//
//  SSWaitForTeacherViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/30/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

enum Status {
    case matched
    case waiting
}

class SSWaitForTeacherViewController: UIViewController {

    let waitingBar = UIView()
    let matchedBar = UIView()
    let color = SSColors.SSGreen
    
    let status = Status.matched
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layoutWaitingBar()
        layoutMatchedBar()
        updateBar()
    }
    
    func layoutWaitingBar() {
        view.addSubview(waitingBar)
        waitingBar.backgroundColor = color
        waitingBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(view.snp.centerY)
        }
        
        let titleView = UILabel()
        waitingBar.addSubview(titleView)
        titleView.text = "Waiting for help..."
        titleView.font = UIFont(name: "Gotham-Medium", size: 20)
        titleView.textColor = .white
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        let timeIconView = UIImageView(image: )
        view.addSubview(timeIconView)
        timeIconView.sizeToFit()
        timeIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
        }
        timeIconView.image = timeIconView.image!.withRenderingMode(.alwaysTemplate)
        timeIconView.tintColor = color
    }
    
    func layoutMatchedBar() {
        view.addSubview(matchedBar)
        matchedBar.backgroundColor = color
        matchedBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(view.snp.centerY)
        }
        
        let titleView = UILabel()
        matchedBar.addSubview(titleView)
        titleView.text = "Help found!"
        titleView.font = UIFont(name: "Gotham-Medium", size: 20)
        titleView.textColor = .white
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func updateBar(){
        matchedBar.isHidden = status != Status.matched
        waitingBar.isHidden = status == Status.matched
    }
}

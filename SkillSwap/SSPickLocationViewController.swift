//
//  SSPickLocationViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/29/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSPickLocationViewController: UIViewController {
    
    var color = SSColors.SSBlue
    var selectedIndex = -1
    let buttons = [UIButton(type: .custom), UIButton(type: .custom), UIButton(type: .custom), UIButton(type: .custom)]
    let titleView = UILabel()
    var locations: Array<SSLocation> = []
    var meetup: SSMeetup?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layoutTopBar()
        
        SSDatabase.getAllMeetupLocations { (success, locs) in
            self.locations = locs
            DispatchQueue.main.async {
                self.layoutLocationButtons()
            }
        }
    }
    
    func layoutLocationButtons() {
        for i in 0...3 {
            let button = buttons[i]
            button.setTitle(locations[i].name, for: .normal)
            button.layer.borderColor = color.cgColor
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.tag = i
            button.titleLabel?.font = UIFont(name: "Gotham-Book", size: 18)
            button.setTitleColor(color, for: .normal)
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(locationSelected(_:)), for: .touchUpInside)
            view.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.top.equalTo(titleView.snp.bottom).offset(60 + 70 * i)
                make.centerX.equalToSuperview()
                make.width.equalTo(260)
                make.height.equalTo(50)
            })
        }
    }
    
    func locationSelected(_ button: UIButton) {
        selectedIndex = button.tag
        for b in buttons {
            if(b.tag == button.tag){
                b.backgroundColor = color
                b.setTitleColor(.white, for: .normal)
            } else {
                b.backgroundColor = .white
                b.setTitleColor(color, for: .normal)
            }
        }
        meetup?.location = locations[selectedIndex]
        let vc = SSDescriptionViewController()
        vc.color = color
        vc.meetup = meetup
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func layoutTopBar () {
        view.addSubview(titleView)
        titleView.text = "Which Location?"
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
        
//        let nextButton = UIButton(type: .custom)
//        let nextimage = UIImage(named: "next_icon")?.withRenderingMode(.alwaysTemplate)
//        nextButton.setImage(nextimage, for: .normal)
//        nextButton.tintColor = color
//        nextButton.sizeToFit()
//        view.addSubview(nextButton)
//        nextButton.addTarget(self, action: #selector(nextButtonSelected), for: .touchUpInside)
//        nextButton.snp.makeConstraints { (make) in
//            make.right.equalTo(-15)
//            make.centerY.equalTo(titleView)
//        }
    }
    
    func backbuttonSelected() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func nextButtonSelected() {
        meetup?.location = locations[selectedIndex]
        let vc = SSDescriptionViewController()
        vc.color = color
        vc.meetup = meetup
        navigationController?.pushViewController(vc, animated: true)
    }
}

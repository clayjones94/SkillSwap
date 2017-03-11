//
//  SSAboutViewController.swift
//  SkillSwap
//
//  Created by Graduates on 3/11/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import SideMenu

class SSAboutViewController: UIViewController {

    let menuButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSideMenu()
        view.backgroundColor = .white
        
        let aboutTitle = UILabel()
        view.addSubview(aboutTitle)
        aboutTitle.font = UIFont(name: "Gotham-Medium", size: 18)
        aboutTitle.textColor = SSColors.SSBlue
        aboutTitle.text = "About SkillSwap"
        aboutTitle.sizeToFit()
        aboutTitle.snp.makeConstraints { (make) in
            make.top.equalTo(menuButton)
            make.centerX.equalToSuperview()
        }
        
        let descriptionLabel = UILabel()
        view.addSubview(descriptionLabel)
        descriptionLabel.text = "All too often people have difficulty learning what they want to do because they lack the resources. We believe that since everyone has a special skill, these resources are in other learners. SkillSwap's purpose is to unite these learners together so that they may learn what they want by teaching what others want."
        descriptionLabel.font = UIFont(name: "Gotham-Book", size: 14)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 9
        descriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(aboutTitle.snp.bottom).offset(30)
            make.width.equalTo(250)
        }
        
        let privacyButton = UIButton()
        privacyButton.setTitle("Privacy Policy", for: .normal)
        privacyButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 18)
        privacyButton.setTitleColor(SSColors.SSBlue, for: .normal)
        privacyButton.layer.cornerRadius = 4
        privacyButton.backgroundColor = .white
        privacyButton.addTarget(self, action: #selector(privacyButtonPressed), for: .touchUpInside)
        view.addSubview(privacyButton)
        privacyButton.snp.makeConstraints({ (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(30)
        })
        
        let creditsLabel = UILabel()
        view.addSubview(creditsLabel)
        creditsLabel.text = "Icon Credits"
        aboutTitle.font = UIFont(name: "Gotham-Medium", size: 18)
        creditsLabel.textColor = SSColors.SSDarkGray
        creditsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(privacyButton.snp.bottom).offset(30)
        }

        let credits1 = UIButton()
        credits1.setTitle("Vincent Le Moign", for: .normal)
        credits1.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        credits1.setTitleColor(SSColors.SSBlue, for: .normal)
        credits1.layer.cornerRadius = 4
        credits1.backgroundColor = .white
        credits1.addTarget(self, action: #selector(credits1Pressed), for: .touchUpInside)
        view.addSubview(credits1)
        credits1.snp.makeConstraints({ (make) in
            make.top.equalTo(creditsLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(30)
        })

        let credits2 = UIButton()
        credits2.setTitle("Netguru", for: .normal)
        credits2.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        credits2.setTitleColor(SSColors.SSBlue, for: .normal)
        credits2.layer.cornerRadius = 4
        credits2.backgroundColor = .white
        credits2.addTarget(self, action: #selector(credits2Pressed), for: .touchUpInside)
        view.addSubview(credits2)
        credits2.snp.makeConstraints({ (make) in
            make.top.equalTo(credits1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        })
    }
    
    func privacyButtonPressed(){
        if let url = NSURL(string: "https://web.stanford.edu/class/cs194h/projects/SkillSwap/privacy") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

    func credits1Pressed(){
        if let url = NSURL(string: "https://freebiesupply.com/free-vector/color-vector-characters/") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    func credits2Pressed(){
        if let url = NSURL(string: "https://freebiesupply.com/free-vector/cartoon-characters-vol-2/") {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func layoutSideMenu(){
        
        let image = UIImage(named: "side_menu")?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(image, for: .normal)
        menuButton.tintColor = SSColors.SSBlue
        menuButton.sizeToFit()
        view.addSubview(menuButton)
        menuButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.top).offset(UIApplication.shared.statusBarFrame.size.height + 28)
            make.leftMargin.equalTo(10)
        }
        
        menuButton.addTarget(self, action: #selector(self.menuPressed), for: .touchUpInside)
    }
    
    func menuPressed() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

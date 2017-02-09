//
//  SSMeetupsViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/8/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import SideMenu

class SSMeetupsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        layoutSideMenu()
    }

    private func layoutSideMenu(){
        
        let menuButton = UIButton(type: .custom)
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

}

//
//  SSMainViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/27/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import SnapKit
import SideMenu

class SSMainViewController: UIViewController {
    
    let learnVC = SSLearnViewController()
    let teachVC = SSTeachViewController()
    let waitVC = SSWaitForTeacherViewController()
    var currentVC :UIViewController? = nil
    
    let waitMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        layoutSegmentedControl()
        layoutSideMenu()
        
        currentVC = learnVC
        controlValueChanged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controlValueChanged()
    }
    
    let segControl = BetterSegmentedControl(
        frame: CGRect.zero,
        titles: ["LEARN", "TEACH"],
        index: 0,
        backgroundColor: .white,
        titleColor: .lightGray,
        indicatorViewBackgroundColor: .white,
        selectedTitleColor: SSColors.SSGreen)
    
    private func layoutSegmentedControl() {
        segControl.titleFont = UIFont(name: "Gotham-Medium", size: 12.0)!
        segControl.indicatorViewBorderColor = SSColors.SSGreen.cgColor
        segControl.indicatorViewBorderWidth = 2
        segControl.indicatorViewInset = 0
        segControl.layer.borderWidth = 0.5
        segControl.layer.borderColor = UIColor.lightGray.cgColor
        segControl.cornerRadius = 18
        segControl.selectedTitleFont = UIFont(name: "Gotham-Medium", size: 12.0)!
        segControl.addTarget(self, action: #selector(self.controlValueChanged), for: .valueChanged)
        view.addSubview(segControl)
        segControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(UIApplication.shared.statusBarFrame.height + 10)
            make.width.equalTo(200)
            make.height.equalTo(36)
        }
    }
    
    private func layoutSideMenu(){
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: SSSideMenuViewController())
        menuLeftNavigationController.view.backgroundColor = .white
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(#imageLiteral(resourceName: "side_menu"), for: .normal)
        menuButton.sizeToFit()
        view.addSubview(menuButton)
        menuButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(segControl)
            make.leftMargin.equalTo(10)
        }
        
        menuButton.addTarget(self, action: #selector(self.menuPressed), for: .touchUpInside)
    }
    
    func controlValueChanged() {
        if segControl.index == 0 {
            if waitMode {
                currentVC = waitVC
            } else {
                currentVC = learnVC
            }
            teachVC.removeFromParentViewController()
        } else {
            currentVC = teachVC
            learnVC.removeFromParentViewController()
            waitVC.removeFromParentViewController()
        }
        self.addChildViewController(currentVC!)
        view.addSubview((currentVC?.view)!)
        currentVC?.view.snp.makeConstraints { (make) in
            make.top.equalTo(segControl.snp.bottom)
            make.bottom.left.right.equalTo(view)
        }
    }
    
    func menuPressed() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

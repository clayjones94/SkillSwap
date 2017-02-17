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
import LFLoginController

class SSMainViewController: UIViewController {
    
    let learnVC = SSLearnViewController()
    let teachVC = SSTeachViewController()
    var waitVC: SSWaitForTeacherViewController?
    var currentVC :UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layoutSegmentedControl()
        layoutSideMenu()
        
        setUpNotifications()
        
        currentVC = learnVC
        controlValueChanged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controlValueChanged()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if !SSCurrentUser.sharedInstance.loggedIn {
            loginUser()
        }
    }
    
    let segControl = BetterSegmentedControl(
        frame: CGRect.zero,
        titles: ["LEARN", "TEACH"],
        index: 0,
        backgroundColor: .white,
        titleColor: .lightGray,
        indicatorViewBackgroundColor: .white,
        selectedTitleColor: SSColors.SSBlue)
    
    private func setUpNotifications() {
        let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SSMainViewController.controlValueChanged), name: notificationName, object: nil)
    }
    
    private func layoutSegmentedControl() {
        segControl.titleFont = UIFont(name: "Gotham-Medium", size: 12.0)!
        segControl.indicatorViewBorderColor = SSColors.SSBlue.cgColor
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
        
        let menuButton = UIButton(type: .custom)
        let image = UIImage(named: "side_menu")?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(image, for: .normal)
        menuButton.tintColor = SSColors.SSBlue
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
            if SSCurrentUser.sharedInstance.learningStatus != .none {
                if waitVC == nil {
                    waitVC = SSWaitForTeacherViewController()
                }
                currentVC = waitVC
            } else {
                currentVC = learnVC
                waitVC = nil
            }
            teachVC.removeFromParentViewController()
        } else {
            currentVC = teachVC
            learnVC.removeFromParentViewController()
            waitVC?.removeFromParentViewController()
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

    func loginUser() {
        //1. Create a LFLoginController instance
        let loginController = SSRegisterViewController()
        let nav = UINavigationController(rootViewController: loginController)
        nav.setToolbarHidden(true, animated: false)
        
        self.present(nav, animated: true, completion: nil)
    }
}

//extension SSMainViewController: LFLoginControllerDelegate {
//    
//    func loginDidFinish(email: String, password: String, type: LFLoginController.SendType) {
//        print(email)
//        print(password)
//        print(type)
//        
//        SSDatabase.registerUser(user: SSUser(id: "1", name: "Clay Jones", phone: "858-472-3180")) { (success, newUser) in
//            if success {
//                SSCurrentUser.sharedInstance.loggedIn = true
//                SSCurrentUser.sharedInstance.user = newUser
//                _ = self.navigationController?.popViewController(animated: true)
//            }
//        }
//    }
//    
//    func forgotPasswordTapped() {
//        
//        print("forgot password")
//    }
//}

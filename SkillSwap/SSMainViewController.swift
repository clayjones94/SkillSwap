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
import KeychainSwift

class SSMainViewController: UIViewController {
    
    let learnVC = SSLearnViewController()
    let teachVC = SSTeachViewController()
    var waitVC: SSWaitForTeacherViewController?
    var currentVC :UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        SSDatabase.getUserInfo { (success) in
            
        }
        
        layoutSegmentedControl()
        layoutSideMenu()
        
        setUpNotifications()
        
        currentVC = learnVC
        controlValueChanged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controlValueChanged()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        checkLogin()
        checkLearningStatus()
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
        
        let loginnotificationName = Notification.Name(LOGIN_STATUS_CHANGED_NOTIFICATION)
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SSMainViewController.checkLogin), name: loginnotificationName, object: nil)
    }
    
    func checkLogin () {
        let loggedIn = KeychainSwift().getBool(LOGGED_IN_KEY)
        if loggedIn == nil {
            loginUser()
        } else if !(loggedIn!) {
            loginUser()
        } else {
            SSCurrentUser.sharedInstance.loggedIn = true
            let phone = KeychainSwift().get(USERNAME_KEY)
            let name = KeychainSwift().get(NAME_KEY)
            SSCurrentUser.sharedInstance.user = SSUser(id: phone!, name: name!, phone: phone!)
            if let timeString = KeychainSwift().get(TIME_BANK_KEY) {
                if let time = NumberFormatter().number(from: timeString) {
                    SSCurrentUser.sharedInstance.user?.time = time as Int?
                }
            }
        }
    }
    
    func checkLearningStatus () {
        SSDatabase.checkWaitingMeetups(completion: { (success, meetups) in
            if (success && (meetups?.count)! > 0){
                SSCurrentUser.sharedInstance.currentMeetupPost = meetups?.first
                SSCurrentUser.sharedInstance.learningStatus = LearningStatus.waiting
                DispatchQueue.main.async {
                    self.controlValueChanged()
                }
            }
        })
        
        SSDatabase.checkMatchedMeetups(completion: { (success, meetups) in
            if (success && (meetups?.count)! > 0){
                SSCurrentUser.sharedInstance.currentMeetupPost = meetups?.first
                SSCurrentUser.sharedInstance.learningStatus = LearningStatus.matched
                DispatchQueue.main.async {
                    self.controlValueChanged()
                }
            }
        })
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
        let name = KeychainSwift().get(NAME_KEY)
        let username = KeychainSwift().get(USERNAME_KEY)
        let password = KeychainSwift().get(PASSWORD_KEY)

        if(name == nil || username == nil || password == nil) {
            let loginController = SSRegisterViewController()
            let nav = UINavigationController(rootViewController: loginController)
            nav.setToolbarHidden(true, animated: false)
            
            self.present(nav, animated: true, completion: nil)
            return
        }
        
        let user = SSUser(id: "", name: name!, phone: username!)
        SSDatabase.loginUser(phone: user.phone!, password: password!) { (success, exists, user) in
            if success {
                SSCurrentUser.sharedInstance.user = user
                SSCurrentUser.sharedInstance.loggedIn = true
            } else {
                let loginController = SSRegisterViewController()
                let nav = UINavigationController(rootViewController: loginController)
                nav.setToolbarHidden(true, animated: false)
                
                self.present(nav, animated: true, completion: nil)
            }
        }
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

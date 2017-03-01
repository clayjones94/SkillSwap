//
//  SSSideMenuViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import SideMenu
import KeychainSwift
import DigitsKit

class SSSideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: .zero, style: UITableViewStyle.plain)
    
    var menuItems: Array<Dictionary<String, Any>>?
    
    var mainViewController: SSMainViewController?
    var meetupViewController: SSMeetupsViewController?
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        layoutView()
        getUser()
    }
    
    func getUser () {
        SSDatabase.getUserInfo { (success) in
            self.layoutView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white;
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        menuItems = [
            [
                "title": "Home",
                "action": #selector(SSSideMenuViewController.home)
            ],
            [
                "title": "Meetups",
                "action": #selector(SSSideMenuViewController.meetups)
            ],
            [
                "title": "Logout",
                "action": #selector(SSSideMenuViewController.logout)
            ]
        ]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
    
    func layoutView() {
        view.addSubview(nameLabel)
        nameLabel.text = SSCurrentUser.sharedInstance.user?.name
        nameLabel.font = UIFont(name: "Gotham-Book", size: 18)
        nameLabel.textColor = SSColors.SSDarkGray
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        
        view.addSubview(timeLabel)
        if let time = SSCurrentUser.sharedInstance.user?.time {
            timeLabel.text = "\(time) minutes"
        } else {
            timeLabel.text = ""
        }
        timeLabel.font = UIFont(name: "Gotham-Book", size: 12)
        timeLabel.textColor = SSColors.SSDarkGray
        timeLabel.textAlignment = .center
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
        perform(menuItems?[indexPath.row]["action"] as! Selector)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "menu cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "menu cell")
        }
        cell?.textLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        
        cell?.textLabel?.text = menuItems?[indexPath.row]["title"] as! String?
        return cell!
    }
    
    func home() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navController?.viewControllers = [mainViewController!]
        dismiss(animated: true, completion: nil)
    }
    
    func meetups () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navController?.viewControllers = [meetupViewController!]
        dismiss(animated: true, completion: nil)
//        navigationController?.pushViewController(meetupViewController, animated: false)
    }
    
    func logout () {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navController?.viewControllers = [mainViewController!]
        dismiss(animated: true) { 
            SSCurrentUser.sharedInstance.loggedIn = false
            SSCurrentUser.sharedInstance.user = nil
            SSCurrentUser.sharedInstance.learningStatus = .none
            SSCurrentUser.sharedInstance.teachingStatus = .none
            let keychain = KeychainSwift()
            keychain.clear()
            let notificationName = Notification.Name(LEARNING_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
            let loginnotificationName = Notification.Name(LOGIN_STATUS_CHANGED_NOTIFICATION)
            NotificationCenter.default.post(name: loginnotificationName, object: nil)
        }
    }
}

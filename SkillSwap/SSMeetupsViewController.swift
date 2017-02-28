//
//  SSMeetupsViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/8/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import SideMenu
import MessageUI

class SSMeetupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var history: Array<SSMeetup> = []
    var active: Array<SSMeetup> = []
    let menuButton = UIButton(type: .custom)
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSideMenu()
        
        let historyTitle = UILabel()
        view.addSubview(historyTitle)
        historyTitle.font = UIFont(name: "Gotham-Medium", size: 18)
        historyTitle.textColor = SSColors.SSBlue
        historyTitle.text = "Meetups"
        historyTitle.sizeToFit()
        historyTitle.snp.makeConstraints { (make) in
            make.top.equalTo(menuButton)
            make.centerX.equalToSuperview()
        }
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(menuButton.snp.bottom).offset(10)
        }
        refreshControl.addTarget(self, action: #selector(SSMeetupsViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.register(SSHistoryTableViewCell.self, forCellReuseIdentifier: "history cell")
        tableView.register(SSMeetupsActiveTableViewCell.self, forCellReuseIdentifier: "active cell")
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refresh() {
        refreshControl.beginRefreshing()
        refreshControl.isHidden = false
        SSDatabase.getUsersMeetups(astate: 2) { (success, meetups) in
            self.active = meetups!
            self.refreshControl.endRefreshing()
            self.refreshControl.isHidden = true
            self.tableView.reloadData()
        }
        SSDatabase.getUsersMeetups(astate: 5) { (success, meetups) in
            self.history = meetups!
            self.refreshControl.endRefreshing()
            self.refreshControl.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Active"
        } else {
            return "History"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return active.count
        } else {
            return history.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "active cell") as! SSMeetupsActiveTableViewCell
            cell.meetup = active[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "history cell") as! SSHistoryTableViewCell
            cell.meetup = history[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 105
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
        if indexPath.section == 0 {
            let meetup = active[indexPath.row]
            if (MFMessageComposeViewController.canSendText()) {
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                
                // Configure the fields of the interface.
                composeVC.recipients = [(meetup.student?.phone!)!]
                
                // Present the view controller modally.
                self.present(composeVC, animated: true, completion: nil)
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func dismissButtonPressed(){
        self.dismiss(animated: true, completion: nil)
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
    
}

//
//  SSMeetupsViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/8/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import SideMenu

class SSMeetupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var history: Array<SSMeetup> = []
    let menuButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSideMenu()
        
        let historyTitle = UILabel()
        view.addSubview(historyTitle)
        historyTitle.font = UIFont(name: "Gotham-Medium", size: 18)
        historyTitle.textColor = SSColors.SSBlue
        historyTitle.text = "History"
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
        
        tableView.register(SSHistoryTableViewCell.self, forCellReuseIdentifier: "teach cell")
        refresh()
    }
    
    func refresh() {
        SSDatabase.getHistory { (success, history) in
            self.history = history!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teach cell") as! SSHistoryTableViewCell
        cell.meetup = history[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let cell = tableView.cellForRow(at: indexPath)
    //        cell?.setSelected(false, animated: false)
    //    }
    
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

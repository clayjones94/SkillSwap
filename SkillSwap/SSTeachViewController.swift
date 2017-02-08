//
//  SSTeachViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import PopupDialog

class SSTeachViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var meetups: Array<SSMeetup> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        tableView.register(SSTeachTableViewCell.self, forCellReuseIdentifier: "teach cell")
        
        refresh()
    }
    
    func refresh() {
        SSDatabase.getAllMeetups { (success, meetups) in
            self.meetups = meetups
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teach cell") as! SSTeachTableViewCell
        cell.meetup = meetups[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)
        layoutDetailPopup(indexPath: indexPath)
    }
    
    func layoutDetailPopup(indexPath: IndexPath){

        let vc = SSTeachDetailViewController()
        vc.meetup = meetups[indexPath.row]
        // Create the dialog
        let popup = PopupDialog(viewController: vc, buttonAlignment: UILayoutConstraintAxis.vertical, transitionStyle: .fadeIn, gestureDismissal: true, completion: nil)
        
        // Create buttons
        let buttonOne = CancelButton(title: "😕 No, thanks") {
            popup.dismiss()
        }
        
        let buttonTwo = DefaultButton(title: "🤓 Teach") {
            SSCurrentUser.sharedInstance.teachingStatus = .matched
            self.present(SSTeacherMatchViewController(), animated: true, completion: nil)
        }
        
        popup.addButtons([buttonOne, buttonTwo])
        
        self.present(popup, animated: true, completion: nil)
    }
}

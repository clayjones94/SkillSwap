//
//  SSTeachViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import PopupDialog
import DropDown

class SSTeachViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let filterView = UIView()
    let subjectsButton = UIButton()
    let subjectDropDown = DropDown()
    let locationsButton = UIButton()
    let locationDropDown = DropDown()
    var meetups: Array<SSMeetup> = []
    var subjects: Array<SSSubject> = []
    var locations: Array<SSLocation> = []
    var filteredMeetups: Array<SSMeetup> = []
    let refreshControl = UIRefreshControl()
    
    var selectedSubject: SSSubject?
    var selectedLocation: SSLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(filterView)
        filterView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(50)
        }
        
        var seperator = UIView()
        seperator.backgroundColor = SSColors.SSLightGray
        filterView.addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        seperator = UIView()
        seperator.backgroundColor = SSColors.SSLightGray
        filterView.addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        seperator = UIView()
        seperator.backgroundColor = SSColors.SSLightGray
        filterView.addSubview(seperator)
        seperator.snp.makeConstraints { (make) in
            make.centerX.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        
        filterView.addSubview(subjectsButton)
        subjectDropDown.anchorView = subjectsButton
        subjectDropDown.backgroundColor = .white
        subjectDropDown.textFont = UIFont(name: "Gotham-Book", size: 12)!
        subjectDropDown.textColor = SSColors.SSBlue
        subjectsButton.addTarget(self, action: #selector(filterSubjects), for: .touchUpInside)
        subjectsButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        subjectsButton.setTitleColor(SSColors.SSBlue, for: .normal)
        subjectsButton.setTitle("▼All Subjects", for: .normal)
        subjectsButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-view.frame.size.width/4)
            make.height.equalTo(30)
            make.width.equalTo(view.frame.size.width/2)
        }
        
        filterView.addSubview(locationsButton)
        locationsButton.setTitle("▼All Locations", for: .normal)
        locationDropDown.anchorView = locationsButton
        locationDropDown.backgroundColor = .white
        locationDropDown.textFont = UIFont(name: "Gotham-Book", size: 12)!
        locationDropDown.textColor = SSColors.SSBlue
        locationsButton.addTarget(self, action: #selector(filterLocations), for: .touchUpInside)
        locationsButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        locationsButton.setTitleColor(SSColors.SSBlue, for: .normal)
        locationsButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(view.frame.size.width/4)
            make.height.equalTo(30)
            make.width.equalTo(view.frame.size.width/2)
        }

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(SSTeachViewController.refresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(filterView.snp.bottom)
        }
        
        tableView.register(SSTeachTableViewCell.self, forCellReuseIdentifier: "teach cell")
        
        refresh()
    }
    
    func filterLocations() {
        var names: Array<String> = ["All Locations"]
        for location in self.locations {
            names.append(location.name!)
        }
        locationDropDown.dataSource = names
        
        locationDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            for location in self.locations {
                if item == location.name {
                    self.selectedLocation = location
                    self.locationsButton.setTitle("▼ " + (self.selectedLocation?.name)!, for: .normal)
                } else if item == "All Locations" {
                    self.locationsButton.setTitle("▼ All Locations", for: .normal)
                    self.selectedLocation = nil
                }
            }
            self.refresh()
        }
        
        locationDropDown.show()
        locationDropDown.dismissMode = .onTap
    }
    
    func filterSubjects() {
        var names: Array<String> = ["All Subjects"]
        for subject in self.subjects {
            names.append(subject.name!)
        }
        subjectDropDown.dataSource = names
        
        subjectDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            for subject in self.subjects {
                if item == subject.name {
                    self.selectedSubject = subject
                    self.subjectsButton.setTitle("▼ " + (self.selectedSubject?.name)!, for: .normal)
                } else if item == "All Subjects" {
                    self.subjectsButton.setTitle("▼ All Subjects", for: .normal)
                    self.selectedSubject = nil
                }
            }
            self.refresh()
        }
        
        subjectDropDown.show()
        subjectDropDown.dismissMode = .onTap
    }
    
    func refresh() {
        refreshControl.beginRefreshing()
        refreshControl.isHidden = false
        SSDatabase.getAllMeetups(plocation: selectedLocation, psubject: selectedSubject) { (success, meetups) in
            self.meetups = meetups!
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.refreshControl.isHidden = true
                self.tableView.reloadData()
            }
        }
        
        SSDatabase.getAllSubjects { (success, subjects) in
            self.subjects = subjects
        }
        
        SSDatabase.getAllMeetupLocations { (success, locations) in
            self.locations = locations
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
            SSDatabase.acceptMeetup(meetup: self.meetups[indexPath.row], completion: { (success) in
                if success {
                    SSCurrentUser.sharedInstance.teachingStatus = .matched
                    let vc = SSTeacherMatchViewController()
                    vc.meetup = self.meetups[indexPath.row]
                    self.present(vc, animated: true, completion: nil)
                } else {
                    
                }
            })
        }
        
        popup.addButtons([buttonOne, buttonTwo])
        
        self.present(popup, animated: true, completion: nil)
    }
}

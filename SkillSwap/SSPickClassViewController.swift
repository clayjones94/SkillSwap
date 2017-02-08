//
//  SSPickClassViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/29/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSPickClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var color = UIColor.lightGray
    var detailColor = UIColor.gray
    var subjectTitle = "Subject"
    var subject: SSSubject?
    var icon = UIImage()
    var meetup: SSMeetup?
    var topics: Array<SSTopic> = []
    
    let searchbar = UITextField()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    private let topView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        layoutTopView()
        layoutSearchAndTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.contentOffset = CGPoint(x: 0, y: -40)
        refreshTopics()
    }
    
    func refreshTopics() {
        tableView.refreshControl?.beginRefreshing()
        tableView.refreshControl?.isHidden = false
        SSDatabase.getAllTopicsForSubject(subject: self.subject!) { (success, topics) in
            self.topics = topics
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.refreshControl?.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    private func layoutTopView() {
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.right.left.top.equalToSuperview()
            make.height.equalTo(view.frame.size.height * 0.25)
        }
        topView.backgroundColor = color
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 1)
        topView.layer.shadowOpacity = 0.25
        topView.layer.shadowRadius = 2
        
        let iconView = UIImageView(image: icon)
        topView.addSubview(iconView)
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = detailColor
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        let titleView = UILabel()
        topView.addSubview(titleView)
        titleView.text = "\(subjectTitle) Help"
        titleView.font = UIFont(name: "Gotham-Book", size: 18)
        titleView.textColor = detailColor
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(10)
        }
        
        let cancelButton = UIButton(type: .custom)
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        cancelButton.sizeToFit()
        topView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonSelected), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(30)
        }
    }
    
    private func layoutSearchAndTable() {
//        view.addSubview(searchbar)
//        searchbar.backgroundColor = .white
//        searchbar.textAlignment = .center
//        searchbar.placeholder = "Search for a topic or class..."
//        searchbar.font = UIFont(name: "Gotham-Medium", size: 14)
//        searchbar.snp.makeConstraints { (make) in
//            make.top.equalTo(topView.snp.bottom).offset(10)
//            make.height.equalTo(44)
//            make.centerX.equalToSuperview()
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//        }
//        searchbar.layer.shadowColor = UIColor.black.cgColor
//        searchbar.layer.shadowOffset = CGSize(width: 0, height: 1)
//        searchbar.layer.shadowOpacity = 0.25
//        searchbar.layer.shadowRadius = 2
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: 0);
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "topic")
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SSPickClassViewController.refreshTopics), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        
        view.sendSubview(toBack: tableView)
    }
    
    func cancelButtonSelected() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topic")
        cell?.textLabel?.textColor = SSColors.SSDarkGray
        cell?.textLabel?.text = topics[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SSPickLocationViewController()
        vc.color = color
        vc.meetup = meetup
        meetup?.topic = topics[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

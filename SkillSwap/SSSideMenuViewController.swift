//
//  SSSideMenuViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSSideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white;
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "menu cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "menu cell")
        }
        cell?.textLabel?.text = "Menu Item"
        return cell!
    }
}

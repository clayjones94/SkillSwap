//
//  SSTeachViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSTeachViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: .zero, style: .plain)

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
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teach cell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

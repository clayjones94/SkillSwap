//
//  SSLearnViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSLearnViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let searchbar = UITextField()
    let subjectCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let subjects = [
        [
            "image": #imageLiteral(resourceName: "comp_sci_icon"),
            "title": "Computer Science",
            "color": SSColors.SSGreen,
            "detail_color": SSColors.SSGreenDetail
        ],
        [
            "image": #imageLiteral(resourceName: "chem_icon"),
            "title": "Chemistry",
            "color": SSColors.SSDarkYellow,
            "detail_color": SSColors.SSDarkYellowDetail
        ],
        [
            "image": #imageLiteral(resourceName: "physics_icon"),
            "title": "Physics",
            "color": SSColors.SSOrange,
            "detail_color": SSColors.SSOrangeDetail
        ],
        [
            "image": #imageLiteral(resourceName: "math_icon"),
            "title": "Math",
            "color": SSColors.SSSkyBlue,
            "detail_color": SSColors.SSSkyBlueDetail
        ],
        [
            "image": #imageLiteral(resourceName: "Writing"),
            "title": "Writing",
            "color": SSColors.SSMint,
            "detail_color": SSColors.SSMintDetail
        ],
        [
            "image": #imageLiteral(resourceName: "psych_icon"),
            "title": "Psychology",
            "color": SSColors.SSViolet,
            "detail_color": SSColors.SSVioletDetail
        ],        [
            "image": #imageLiteral(resourceName: "math_icon"),
            "title": "Math",
            "color": SSColors.SSSkyBlue,
            "detail_color": SSColors.SSSkyBlueDetail
        ],
                  [
                    "image": #imageLiteral(resourceName: "Writing"),
                    "title": "Writing",
                    "color": SSColors.SSMint,
                    "detail_color": SSColors.SSMintDetail
        ],
                  [
                    "image": #imageLiteral(resourceName: "psych_icon"),
                    "title": "Psychology",
                    "color": SSColors.SSViolet,
                    "detail_color": SSColors.SSVioletDetail
        ],
        ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        layoutViews()
    }

    private func layoutViews() {
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Gotham-Medium", size: 16)
        titleLabel.textColor = SSColors.SSGreen
        titleLabel.text = "Need a tutor?"
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(view)
        }
        
        subjectCollectionView.register(SSSubjectCell.self, forCellWithReuseIdentifier: "subject")
        subjectCollectionView.backgroundColor = .white
        subjectCollectionView.delegate = self
        subjectCollectionView.dataSource = self
        subjectCollectionView.bounces = true
        view.addSubview(subjectCollectionView)
        subjectCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 20, left: 20, bottom: 5, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subject", for: indexPath) as! SSSubjectCell
        
        cell.color = subjects[indexPath.row]["color"] as! UIColor
        cell.detailColor = subjects[indexPath.row]["detail_color"] as! UIColor
        cell.subjectTitle = subjects[indexPath.row]["title"] as! String
        cell.iconView.image = subjects[indexPath.row]["image"] as! UIImage?
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SSPickClassViewController();
        vc.color = subjects[indexPath.row]["color"] as! UIColor
        vc.detailColor = subjects[indexPath.row]["detail_color"] as! UIColor
        vc.subjectTitle = subjects[indexPath.row]["title"] as! String
        vc.icon = (subjects[indexPath.row]["image"] as! UIImage?)!
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
}

class SSSubjectCell: UICollectionViewCell {
    
    var color = SSColors.SSGreen
    var detailColor = SSColors.SSGreenDetail
    var subjectTitle = "Unknown"
    let titleView = UILabel()
    let iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 2
        layer.cornerRadius = 3
        backgroundColor = .white
        
        addSubview(titleView)
        titleView.textAlignment = .center
        titleView.backgroundColor = SSColors.SSLightGray
        titleView.font = UIFont(name: "Gotham-Book", size: 12)
        titleView.textColor = SSColors.SSDarkGray
        
        addSubview(iconView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = color
        titleView.text = subjectTitle
        titleView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(34)
        }
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-17)
        }
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = detailColor
    }
}

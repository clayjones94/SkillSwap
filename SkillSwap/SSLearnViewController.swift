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
    var subjects = Array<SSSubject>()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        refreshSubjects()
        
        layoutViews()
    }

    private func layoutViews() {
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Gotham-Medium", size: 16)
        titleLabel.textColor = SSColors.SSBlue
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
        
        cell.color = subjects[indexPath.row].color!
        cell.detailColor = detailColorForColor(color: subjects[indexPath.row].color!)
        cell.subjectTitle = subjects[indexPath.row].name!
        cell.iconView.image = subjects[indexPath.row].image!
        cell.iconView.image = cell.iconView.image!.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SSPickClassViewController()
        vc.subject = subjects[indexPath.row]
        vc.color = subjects[indexPath.row].color!
        vc.detailColor = detailColorForColor(color: subjects[indexPath.row].color!)
        vc.subjectTitle = subjects[indexPath.row].name!
        vc.icon = subjects[indexPath.row].image!
        vc.meetup = SSMeetup(id: "")
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
    
    func refreshSubjects() {
        SSDatabase.getAllSubjects { (success, subjects) in
            self.subjects = subjects
            DispatchQueue.main.async {
                self.subjectCollectionView.reloadData()
            }
        }
    }
}

class SSSubjectCell: UICollectionViewCell {
    
    var color = SSColors.SSBlue
    var detailColor = SSColors.SSBlueDetail
    var subjectTitle = "Unknown"
    let titleView = UILabel()
    let iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 1)
//        layer.shadowOpacity = 0.25
//        layer.shadowRadius = 2
        layer.cornerRadius = 3
        backgroundColor = .white
        
        addSubview(titleView)
        titleView.textAlignment = .center
        titleView.backgroundColor = .white
        titleView.font = UIFont(name: "Gotham-Book", size: 12)
        titleView.layer.borderWidth = 2
        titleView.layer.cornerRadius = 3
        titleView.clipsToBounds = true
        titleView.layer.borderColor = color.cgColor
        titleView.textColor = SSColors.SSDarkGray
        
        addSubview(iconView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = color
        titleView.text = subjectTitle.lowercased()
        titleView.layer.borderColor = color.cgColor
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

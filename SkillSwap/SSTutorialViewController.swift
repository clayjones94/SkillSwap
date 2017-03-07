//
//  SSTutorialViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 3/2/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import ChameleonFramework

struct Page {
    var icon: UIImage
    var label1: String
    var label2: String
}

let pages = [
    Page(icon: #imageLiteral(resourceName: "tutorial_1"), label1: "Jason needs help on an assignment.", label2: "He makes a SkillSwap Request."),
    Page(icon: #imageLiteral(resourceName: "tutorial_2"), label1: "Brad can help!", label2: "He accepts Jason’s request."),
    Page(icon: #imageLiteral(resourceName: "tutorial_3"), label1: "Brad and Jason meet to swap skills.", label2: "Jason gets help on his assignment for 30 minutes."),
    Page(icon: #imageLiteral(resourceName: "tutorial_4"), label1: "Jason gives Brad 30 minutes of credit. ", label2: "Brad can use that credit for future help."),
]

class SSTutorialViewController: UIViewController {
    
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var viewControllers: [UIViewController]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViewController(pageController)
        view.addSubview((pageController.view)!)
        
        pageController.delegate = self
        pageController.dataSource = self
        pageController.setViewControllers([self.viewControllerAtIndex(index: 0)], direction: .forward, animated: true) { (completed) in
            
        }
        
        let color1 = hexStringToUIColor(hex: "00A0EA")
        let color2 = hexStringToUIColor(hex: "91DCFF")
        pageController.view.backgroundColor = UIColor.init(gradientStyle: .topToBottom, withFrame: pageController.view.frame, andColors: [color2, color1])
        
        let cancelButton = UIButton(type: .custom)
        let image = UIImage(named: "back_icon")?.withRenderingMode(.alwaysTemplate)
        cancelButton.setImage(image, for: .normal)
        cancelButton.tintColor = .white
        cancelButton.sizeToFit()
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(backbuttonSelected), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(25)
        }
        
        let timeLabel = UILabel()
        view.addSubview(timeLabel)
        timeLabel.textColor = .white
        timeLabel.font = UIFont(name: "Gotham-Book", size: 36)
        timeLabel.textAlignment = .center
        timeLabel.text = "\((SSCurrentUser.sharedInstance.user?.time)!)"
        timeLabel.sizeToFit()
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(60)
        }
        
        let timeDetail = UILabel()
        view.addSubview(timeDetail)
        timeDetail.textColor = .white
        timeDetail.font = UIFont(name: "Gotham-Book", size: 12)
        timeDetail.textAlignment = .center
        timeDetail.text = "Minutes"
        timeDetail.sizeToFit()
        timeDetail.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(-5)
        }
        
        let creditLabel = UILabel()
        view.addSubview(creditLabel)
        creditLabel.textColor = .white
        creditLabel.font = UIFont(name: "Gotham-Book", size: 12)
        creditLabel.textAlignment = .center
        creditLabel.text = "Your credit:"
        creditLabel.sizeToFit()
        creditLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(timeLabel.snp.top).offset(0)
        }
    }
    
    func viewControllerAtIndex(index: Int)-> ContentViewController {
        if (pages.count == 0) || (index >= pages.count){
            return ContentViewController()
        }
        let vc = ContentViewController()
        vc.pageIndex = index
        return vc
    }
    
    func backbuttonSelected() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SSTutorialViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if (index == NSNotFound) {
            return nil
        }
        index += 1
        if(index == pages.count){
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension SSTutorialViewController: UIPageViewControllerDelegate {
    
}

class ContentViewController: UIViewController {
    var pageIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let page = pages[pageIndex]
        
        let iconView = UIImageView(image: page.icon)
        view.addSubview(iconView)
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY).offset(50)
        }
        
        let seperator = UIView()
        view.addSubview(seperator)
        seperator.backgroundColor = .white
        seperator.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).multipliedBy(1.6)
        }
        
        let label1 = UILabel()
        view.addSubview(label1)
        label1.text = page.label1
        label1.textColor = .white
        label1.numberOfLines = 0
        label1.textAlignment = .center
        label1.font = UIFont(name: "Gotham-Book", size: 14)
        label1.sizeToFit()
        label1.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).multipliedBy(1.45)
            make.width.equalTo(200)
        }
        
        let label2 = UILabel()
        view.addSubview(label2)
        label2.text = page.label2
        label2.textColor = .white
        label2.textAlignment = .center
        label2.numberOfLines = 0
        label2.font = UIFont(name: "Gotham-Book", size: 14)
        label2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).multipliedBy(1.75)
            make.width.equalTo(200)
        }
    }
}

//
//  SSRegisterNameViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/28/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import PopupDialog

class SSRegisterNameViewController: UIViewController {
    
    let nameField = UITextField()
    let enterButton = UIButton()
    var userID: String?
    var phone: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "login_background"))
        backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        let overlayView = UIView()
        view.addSubview(overlayView)
        overlayView.backgroundColor = hexStringToUIColor(hex: "006A9C").withAlphaComponent(0.75)
        overlayView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }

        nameField.font = UIFont(name: "Gotham-Book", size: 14)
        view.addSubview(nameField)
        nameField.backgroundColor = SSColors.SSGray.withAlphaComponent(0.35)
        nameField.textColor = .white
        nameField.placeholder = "Enter your name"
        nameField.textAlignment = .center
        nameField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(70)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        enterButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        view.addSubview(enterButton)
        enterButton.backgroundColor = SSColors.SSBlue
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.setTitle("Finish", for: .normal)
        enterButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        enterButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        enterButton.layer.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameField.becomeFirstResponder()
    }

    func register () {
        SSAnimations().popAnimateButton(button: enterButton)
        if ((nameField.text?.characters.count)! < 1) {
            let popup = PopupDialog(title: "Whoops", message: "Must fill in your name")
            let buttonOne = CancelButton(title: "dimiss") {}
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        enterButton.isUserInteractionEnabled = false
        let user = SSUser(id: "", name: nameField.text!, phone: phone!)
        SSDatabase.registerUser(user: user, password: userID!) { (success, user) in
            self.enterButton.isUserInteractionEnabled = true
            if success {
                SSCurrentUser.sharedInstance.user = user
                SSCurrentUser.sharedInstance.loggedIn = true
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                let popup = PopupDialog(title: "Error", message: "Could not register")
                let buttonOne = CancelButton(title: "dismiss") {}
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
    }

}

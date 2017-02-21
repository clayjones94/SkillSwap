//
//  SSRegisterViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/16/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import PopupDialog
import KeychainSwift

class SSRegisterViewController: UIViewController {
    
    let nameField = UITextField()
    let phoneField = UITextField()
    let passwordField = UITextField()
    let registerButton = UIButton()
    let loginButton = UIButton()

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
        
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        titleLabel.text = "skillswap"
        titleLabel.font = UIFont(name: "Gotham-Medium", size: 36)
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        nameField.font = UIFont(name: "Gotham-Book", size: 14)
        view.addSubview(nameField)
        nameField.backgroundColor = SSColors.SSGray.withAlphaComponent(0.35)
        nameField.textColor = .white
        nameField.placeholder = "name"
        nameField.textAlignment = .center
        nameField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        phoneField.font = UIFont(name: "Gotham-Book", size: 14)
        view.addSubview(phoneField)
        phoneField.backgroundColor = SSColors.SSGray.withAlphaComponent(0.35)
        phoneField.textColor = .white
        phoneField.placeholder = "mobile"
        phoneField.textAlignment = .center
        phoneField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameField.snp.bottom).offset(20)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        passwordField.font = UIFont(name: "Gotham-Book", size: 14)
        view.addSubview(passwordField)
        passwordField.backgroundColor = SSColors.SSGray.withAlphaComponent(0.35)
        passwordField.textColor = .white
        passwordField.placeholder = "password"
        passwordField.textAlignment = .center
        passwordField.isSecureTextEntry = true
        passwordField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneField.snp.bottom).offset(20)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        registerButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
        view.addSubview(registerButton)
        registerButton.backgroundColor = SSColors.SSBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitle("REGISTER", for: .normal)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordField.snp.bottom).offset(20)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
        loginButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 12)
        view.addSubview(loginButton)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Already have an account? Sign in", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.width.equalTo(250)
            make.height.equalTo(20)
        }
    }
    
    func login() {
        navigationController?.pushViewController(SSLoginViewController(), animated: false)
    }
    
    func register() {
        SSAnimations().popAnimateButton(button: registerButton)
        if (nameField.text?.characters.count)! < 1 || (passwordField.text?.characters.count)! < 1 || (phoneField.text?.characters.count)! < 1 {
            let popup = PopupDialog(title: "Whoops", message: "Must fill in fields!")
            let buttonOne = CancelButton(title: "dimiss") {}
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        registerButton.isUserInteractionEnabled = false
        let user = SSUser(id: "", name: nameField.text!, phone: phoneField.text!)
        SSDatabase.registerUser(user: user, password: passwordField.text!) { (success, user) in
            self.registerButton.isUserInteractionEnabled = true
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

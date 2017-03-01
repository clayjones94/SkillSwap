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
import DigitsKit


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
            make.top.equalToSuperview().offset(120)
        }
        
//        nameField.font = UIFont(name: "Gotham-Book", size: 14)
//        view.addSubview(nameField)
//        nameField.backgroundColor = SSColors.SSGray.withAlphaComponent(0.35)
//        nameField.textColor = .white
//        nameField.placeholder = "name"
//        nameField.textAlignment = .center
//        nameField.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(titleLabel.snp.bottom).offset(20)
//            make.width.equalTo(250)
//            make.height.equalTo(40)
//        }
//        
//        phoneField.font = UIFont(name: "Gotham-Book", size: 14)
//        view.addSubview(phoneField)
//        phoneField.backgroundColor = SSColors.SSGray.withAlphaComponent(0.35)
//        phoneField.textColor = .white
//        phoneField.placeholder = "mobile"
//        phoneField.textAlignment = .center
//        phoneField.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(nameField.snp.bottom).offset(20)
//            make.width.equalTo(250)
//            make.height.equalTo(40)
//        }
//        
//        passwordField.font = UIFont(name: "Gotham-Book", size: 14)
//        view.addSubview(passwordField)
//        passwordField.backgroundColor = SSColors.SSGray.withAlphaComponent(0.35)
//        passwordField.textColor = .white
//        passwordField.placeholder = "password"
//        passwordField.textAlignment = .center
//        passwordField.isSecureTextEntry = true
//        passwordField.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(phoneField.snp.bottom).offset(20)
//            make.width.equalTo(250)
//            make.height.equalTo(40)
//        }
//        
//        registerButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 14)
//        view.addSubview(registerButton)
//        registerButton.backgroundColor = SSColors.SSBlue
//        registerButton.setTitleColor(.white, for: .normal)
//        registerButton.setTitle("REGISTER", for: .normal)
//        registerButton.addTarget(self, action: #selector(didTapAuth), for: .touchUpInside)
//        registerButton.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(view).offset(20)
//            make.width.equalTo(250)
//            make.height.equalTo(40)
//        }
        
//        loginButton.titleLabel?.font = UIFont(name: "Gotham-Book", size: 12)
//        view.addSubview(loginButton)
//        loginButton.setTitleColor(.white, for: .normal)
//        loginButton.setTitle("Already have an account? Sign in", for: .normal)
//        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
//        loginButton.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(registerButton.snp.bottom).offset(15)
//            make.width.equalTo(250)
//            make.height.equalTo(20)
//        }
        
        let authButton = DGTAuthenticateButton(authenticationCompletion: { (session: DGTSession?, error: Error?) in
            if (session != nil) {
                SSDatabase.loginUser(phone: session!.phoneNumber, password: session!.userID!, completion: { (success, exists, user) in
                    if (success && exists){
                        SSCurrentUser.sharedInstance.user = user
                        SSCurrentUser.sharedInstance.loggedIn = true
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        let vc = SSRegisterNameViewController()
                        vc.phone = session!.phoneNumber
                        vc.userID = session!.userID
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                })
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        })
        self.view.addSubview(authButton!)
        authButton?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(0)
            make.height.equalTo(40)
        })
        authButton?.setTitle("Phone Number", for: .normal)
        authButton?.digitsAppearance = self.makeTheme()
        authButton?.layer.cornerRadius = 20
        self.view.addSubview(authButton!)
        
        let detailLabel = UILabel()
        detailLabel.textColor = .white
        view.addSubview(detailLabel)
        detailLabel.text = "Sign Up or Login with"
        detailLabel.font = UIFont(name: "Gotham-Book", size: 12)
        detailLabel.sizeToFit()
        detailLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo((authButton?.snp.top)!).offset(-10)
        }
    }
    
    func makeTheme() -> DGTAppearance {
        let theme = DGTAppearance();
        theme.bodyFont = UIFont(name: "Gotham-Book", size: 14);
        theme.labelFont = UIFont(name: "Gotham-Medium", size: 17);
        theme.accentColor = SSColors.SSBlue
        theme.backgroundColor = UIColor(red: (240.0/255.0), green: (255/255.0), blue: (250/255.0), alpha: 1);
        // TODO: set a UIImage as a logo with theme.logoImage
        return theme;
    }

    
    func login() {
        navigationController?.pushViewController(SSLoginViewController(), animated: false)
    }
    
//    func didTapAuth () {
//        let digits = Digits.sharedInstance()
//        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
//        digits.authenticate(with: nil, configuration: configuration!) { session, error in
//            if (session != nil) {
//                // TODO: associate the session userID with your user model
//                let message = "Phone number: \(session!.phoneNumber)"
//                let alertController = UIAlertController(title: "You are logged in!", message: message, preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: .none))
//                self.present(alertController, animated: true, completion: .none)
//            } else {
//                NSLog("Authentication error: %@", error!.localizedDescription)
//            }
//        }
//    }
    
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

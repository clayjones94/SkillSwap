//
//  SSDescriptionViewController.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/30/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import AnimatedTextInput

class SSDescriptionViewController: UIViewController, AnimatedTextInputDelegate {

    let titleView = UILabel()
    var color = SSColors.SSGreen
    let subjectField = AnimatedTextInput()
    let detailTextView = AnimatedTextInput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        layoutTopBar()
        layoutTextFields()
        
    }
    
    func layoutTopBar () {
        view.addSubview(titleView)
        titleView.text = "Explain"
        titleView.font = UIFont(name: "Gotham-Medium", size: 18)
        titleView.textColor = color
        titleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        let cancelButton = UIButton(type: .custom)
        let image = UIImage(named: "back_icon")?.withRenderingMode(.alwaysTemplate)
        cancelButton.setImage(image, for: .normal)
        cancelButton.tintColor = color
        cancelButton.sizeToFit()
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(backbuttonSelected), for: .touchUpInside)
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(titleView)
        }
        
        let nextButton = UIButton(type: .custom)
        let nextimage = UIImage(named: "next_icon")?.withRenderingMode(.alwaysTemplate)
        nextButton.setImage(nextimage, for: .normal)
        nextButton.tintColor = color
        nextButton.sizeToFit()
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonSelected), for: .touchUpInside)
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(titleView)
        }
    }
    
    func layoutTextFields(){
        view.addSubview(subjectField)
        subjectField.placeHolderText = "Summary"
        subjectField.style = AnimatedTextInputStyleRed(color: color)
        subjectField.showCharacterCounterLabel(with: 30)
        subjectField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(25)
            make.width.equalTo(280)
        }
        
        subjectField.becomeFirstResponder()
        
        view.addSubview(detailTextView)
        detailTextView.placeHolderText = "Details"
        detailTextView.style = AnimatedTextInputStyleRed(color: color)
        detailTextView.showCharacterCounterLabel(with: 300)
        detailTextView.type = .multiline
        detailTextView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(subjectField.snp.bottom).offset(20)
            make.width.equalTo(280)
        }
    }
    
    func backbuttonSelected() {
        navigationController?.popViewController(animated: true)
    }
    
    func nextButtonSelected() {
        let vc = SSSelectTimeViewController()
        vc.color = color
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func animatedTextInput(animatedTextInput: AnimatedTextInput, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

struct AnimatedTextInputStyleRed: AnimatedTextInputStyle {
    
    var activeColor = UIColor(red: 51.0/255.0, green: 175.0/255.0, blue: 236.0/255.0, alpha: 1.0)
    let inactiveColor = UIColor.gray.withAlphaComponent(0.5)
    let lineInactiveColor = UIColor.gray.withAlphaComponent(0.2)
    let errorColor = UIColor.red
    let textInputFont = UIFont.systemFont(ofSize: 14)
    let textInputFontColor = UIColor.black
    let placeholderMinFontSize: CGFloat = 9
    let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
    let leftMargin: CGFloat = 25
    let topMargin: CGFloat = 20
    let rightMargin: CGFloat = 0
    let bottomMargin: CGFloat = 10
    let yHintPositionOffset: CGFloat = 7
    let yPlaceholderPositionOffset: CGFloat = 0
    
    public init(color:UIColor) {activeColor = color}
}

//struct SSAnimatedTextInputStyle: AnimatedTextInputStyle {
//    
//    let activeColor = SSColors.SSDarkGray
//    let inactiveColor = UIColor.gray.withAlphaComponent(0.5)
//    let lineInactiveColor = UIColor.gray.withAlphaComponent(0.2)
//    let errorColor = UIColor.red
//    let textInputFont = UIFont(name: "Gotham-Book", size: 14)
//    let textInputFontColor = UIColor.black
//    let placeholderMinFontSize: CGFloat = 9
//    let counterLabelFont: UIFont? = UIFont(name: "Gotham-Book", size: 9)
//    let leftMargin: CGFloat = 25
//    let topMargin: CGFloat = 20
//    let rightMargin: CGFloat = 0
//    let bottomMargin: CGFloat = 10
//    let yHintPositionOffset: CGFloat = 7
//    let yPlaceholderPositionOffset: CGFloat = 0
//    
//    public init() { }
//}

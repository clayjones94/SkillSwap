//
//  SSIconLabelButton.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/27/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSIconLabelButton: UIButton {
    
    let detailLabel = UILabel()
    let iconView = UIImageView()
    
    var detailText: String?
    var icon: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(detail: String, icon: UIImage){
        super.init(frame: CGRect.zero)
        self.detailText = detail
        self.icon = icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.addSubview(detailLabel)
        detailLabel.text = detailText
        detailLabel.textAlignment = .center
        detailLabel.font = UIFont(name: "Gotham-Book", size: 10)
        detailLabel.textColor = self.tintColor
        
        self.addSubview(iconView)
        iconView.image = icon
        iconView.image = iconView.image!.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = self.tintColor
        
        iconView.sizeToFit()
        iconView.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
        }
        
        detailLabel.sizeToFit()
        detailLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-3)
            make.centerX.equalToSuperview()
        }
    }
}

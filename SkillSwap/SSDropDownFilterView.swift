//
//  SSDropDownFilterView.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/15/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

protocol SSFilterViewDelegate: class {
    func numberOfDropDownSections(view: SSFilterView) -> Int
    func numberOfRows(view: SSFilterView, inSection: Int) -> Int
    func titleFor(view: SSFilterView, indexPath: IndexPath) -> String
    func didSelectOption(view: SSFilterView, indexPath: IndexPath)
}

class SSFilterView: UIView {
    
    weak var delegate:SSFilterViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

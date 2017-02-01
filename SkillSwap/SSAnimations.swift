//
//  SSAnimations.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/31/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSAnimations: NSObject {
    
    func popAnimateButton(button :UIButton) {
        button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 5.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        button.transform = .identity
            },
                       completion: nil)
    }

}

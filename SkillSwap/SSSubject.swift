//
//  SSSubject.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/6/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

enum SubjectState {
    case active
    case inactive
}

class SSSubject: NSObject {
    var name: String?
    var state: SubjectState?
    var id: String?
    var color: UIColor?
    var image: UIImage?
    
    init(id: String, name: String, state: SubjectState, colorHex: String) {
        self.id = id
        self.name = name
        self.state = state
        self.color = hexStringToUIColor(hex: colorHex)
    }
}

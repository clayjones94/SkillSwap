//
//  SSUser.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/3/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSUser: NSObject {

    var name: String?
    var phone: String?
    var id: String?
    var time: Int?
    var photo: NSString?
    
    init(id: String, name: String, phone: String) {
        self.id = id
        self.name = name
        self.phone = phone
    }
}

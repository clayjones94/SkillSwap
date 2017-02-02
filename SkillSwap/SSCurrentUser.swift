//
//  SSCurrentUser.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/1/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSCurrentUser: NSObject {
    
    static let sharedInstance = SSCurrentUser()
    
    var name: String = ""
    var phone: String = ""
    var loggedIn: Bool = false
    
    var teachingStatus: TeachingStatus = .none
    var learningStatus: LearningStatus = .matched
}

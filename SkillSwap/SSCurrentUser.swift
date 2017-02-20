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
    
    override init() {
//        user = SSStorage.sharedInstance.currentUser
    }
    
    var user: SSUser?
    var loggedIn = false
    var currentMeetupPost: SSMeetup?
    
    var teachingStatus: TeachingStatus = .none
    var learningStatus: LearningStatus = .none
}

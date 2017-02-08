//
//  SSTutorSession.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/3/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

enum MeetupState {
    case active
    case matched
    case expired
    case finished
    case canceled
}

class SSMeetup {
    var createdDate: NSDate?
    var expirationDate: NSDate?
    var teacher: SSUser?
    var student: SSUser?
    var state: MeetupState
    var location: SSLocation?
    var topic: SSTopic?
    var timeExchange: Int?
    var summary: String?
    var details: String?
    var id: NSString
    
    init(id :NSString) {
        state = .active
        self.id = id
    }
    
    init(id :NSString, student :SSUser, summary :String, details :String, location :SSLocation, topic: SSTopic, timeExchange: Int) {
        state = .active
        self.id = id
        self.student = student
        self.summary = summary
        self.details = details
        self.location = location
        self.topic = topic
        self.timeExchange = timeExchange
    }
}

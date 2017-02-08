//
//  SSTopic.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/6/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

enum TopicState {
    case active
    case inactive
}

class SSTopic: NSObject {
    var name: String?
    var state: TopicState?
    var subject: SSSubject?
    var id: String?
    
    init(id: String, name: String, subject: SSSubject, state: TopicState) {
        self.id = id
        self.name = name
        self.state = state
        self.subject = subject
    }
}

//
//  SSConstants.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/1/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import Foundation

public enum TeachingStatus {
    case matched
    case none
}

public enum LearningStatus {
    case matched
    case waiting
    case none
}

public let LEARNING_STATUS_CHANGED_NOTIFICATION = "LEARNING_STATUS_CHANGED_NOTIFICATION"


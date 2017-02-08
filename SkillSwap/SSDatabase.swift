//
//  SSDatabase.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/6/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSDatabase {
    
    class func registerUser (user: SSUser, completion: @escaping (_ success: Bool, _ user: SSUser)->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true, SSStorage.sharedInstance.currentUser)
        })
    }
    
    class func loginUser(user: SSUser, completion: @escaping (_ success: Bool, _ user: SSUser)->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true, SSStorage.sharedInstance.currentUser)
        })
    }
    
    class func getAllSubjects(completion: @escaping (_ success: Bool, _ subjects: Array<SSSubject>)->()) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true, SSStorage.sharedInstance.getAllSubjects())
//        })
    }
    
    class func getAllTopicsForSubject(subject: SSSubject, completion: @escaping (_ success: Bool, _ subjects: Array<SSTopic>)->()) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true, SSStorage.sharedInstance.getTopicsForSubject(subject: subject))
//        })
    }
    
    class func getAllMeetupLocations(completion: @escaping (_ success: Bool, _ subjects: Array<SSLocation>)->()) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true, SSStorage.sharedInstance.getLocations())
//        })
    }
    
    class func getAllMeetups(completion: @escaping (_ success: Bool, _ subjects: Array<SSMeetup>)->()) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true, SSStorage.sharedInstance.getAllMeetups())
//        })
    }
    
    class func postMeetup(meetup: SSMeetup, completion: @escaping (_ success: Bool)->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true)
        })
    }
    
    class func cancelMeetup(completion: @escaping (_ success: Bool)->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true)
        })
    }
    
    class func requestToTeach(meetup: SSMeetup, completion: @escaping (_ success: Bool)->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true)
        })
    }
    
    class func endMeetup(meetup: SSMeetup, withExchange exchange: Int, completion: @escaping (_ success: Bool)->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true)
        })
    }
}

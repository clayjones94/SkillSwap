//
//  SSDatabase.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/6/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import Alamofire
import KeychainSwift

let url = "https://skillswapserver.herokuapp.com"

class SSDatabase {
    
    class func registerUser (user: SSUser, password: String, completion: @escaping (_ success: Bool, _ user: SSUser?)->()) {
        var parameters: Parameters = [
            "phone": user.phone!,
            "name": user.name!,
            "photo": "/profile",
            "major": "Computer Science",
            "password": password
        ]
        
        if let apns = SSCurrentUser.sharedInstance.apnsToken {
            parameters = [
                "phone": user.phone!,
                "name": user.name!,
                "photo": "/profile",
                "major": "Computer Science",
                "password": password,
                "apnsToken":apns
            ]
        }
        Alamofire.request("\(url)/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
//                let success = json?["success"] as? Bool
                if (json?["phone"] as? String) != nil {
                    let phone = json?["phone"] as? String
                    let name = json?["name"] as? String
                    let user = SSUser(id: phone!, name: name!, phone: phone!)
                    let time = json?["timebank"] as? Int
                    user.time = time
                    let keychain = KeychainSwift()
                    keychain.set(phone!, forKey: USERNAME_KEY)
                    keychain.set(password, forKey: PASSWORD_KEY)
                    keychain.set(name!, forKey: NAME_KEY)
                    keychain.set(true, forKey: LOGGED_IN_KEY)
                    if let timeString = NumberFormatter().string(from: NSNumber.init(value: time!)) {
                        keychain.set(timeString, forKey: TIME_BANK_KEY)
                    }
                    completion(true, user)
                } else {
                    completion(false, nil)
                }
        }
    }
    
    class func loginUser(phone: String, password: String, completion: @escaping (_ success: Bool, _ exists: Bool, _ user: SSUser?)->()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let parameters: Parameters = [
            "phone": phone,
            "password": password,
            "apnsToken":appDelegate.strDeviceToken
        ]
        Alamofire.request("\(url)/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
                let success = json?["success"] as? Bool
                if (success == true) {
                    let data = json?["data"] as? [String: Any]
                    let phone = data?["phone"] as? String
                    let name = data?["name"] as? String
                    let user = SSUser(id: phone!, name: name!, phone: phone!)
                    let keychain = KeychainSwift()
                    keychain.set(phone!, forKey: USERNAME_KEY)
                    keychain.set(password, forKey: PASSWORD_KEY)
                    keychain.set(name!, forKey: NAME_KEY)
                    keychain.set(true, forKey: LOGGED_IN_KEY)
                    let time = data?["timebank"] as? Int
                    user.time = time
                    if let timeString = NumberFormatter().string(from: NSNumber.init(value: user.time!)) {
                        keychain.set(timeString, forKey: TIME_BANK_KEY)
                    }
                    completion(true, true, user)
                } else {
                    completion(false, false, nil)
                }
        }
    }
    
    class func getAllSubjects(completion: @escaping (_ success: Bool, _ subjects: Array<SSSubject>)->()) {
        
        completion(true, SSStorage.sharedInstance.getAllSubjects())
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
    
    class func getAllMeetups(plocation: SSLocation?, psubject: SSSubject?, completion: @escaping (_ success: Bool, _ subjects: Array<SSMeetup>?)->()) {
        
        let parameters: Parameters = [
            "state": 1
        ]
        
        Alamofire.request("\(url)/getMeetups", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json as Any)
                let success = json?["success"] as? Bool
                var meetups: Array<SSMeetup> = []
                if (success == true) {
                    let data = json?["data"] as? Array<[String: Any]>
                    for meetupJson in data! {
                        
                        //summary and details
                        let summary = meetupJson["summary"] as! String
                        let details = meetupJson["details"] as! String
                        
                        // teacher { name, phone }
//                        let teacher = meetupJson["teacherInfo"] as! [String: String]?
//                        var ssTeacher: SSUser?
//                        if teacher != nil{
//                            ssTeacher = SSUser(id: "na", name: (teacher?["name"]!)!, phone: (teacher?["phone"]!)!)
//                        }
                        
                        // student { name, phone }
                        let studentPhone = meetupJson["student"] as! String
                        let student = meetupJson["studentInfo"] as! [String: Any]
                        let studentName = student["name"]  as! String
                        let ssStudent = SSUser(id: studentPhone, name: studentName, phone: studentPhone)
                        
                        //time and state
                        let timeExchange = meetupJson["timeExchange"] as! Int
                        let state = meetupJson["state"] as! Int
                        
                        //location { name, address }
                        let address = meetupJson["address"] as! String
                        var location: SSLocation?
                        for sslocation in SSStorage.sharedInstance.getLocations() {
                            if sslocation.address == address {
                                location = sslocation
                            }
                        }
                        
                        let createdDate = meetupJson["createddate"] as! TimeInterval
                        let date = NSDate.init(timeIntervalSinceReferenceDate: createdDate)
                        
//                        let topicInfo = meetupJson["topicInfo"] as! [String: Any]
                        
                        let subjectName = meetupJson["subject"] as! String
                        var subject: SSSubject?
                        for sssubject in SSStorage.sharedInstance.getAllSubjects() {
                            if sssubject.name == subjectName {
                                subject = sssubject
                            }
                        }
                        
                        //topic { name }
                        let topicName = meetupJson["topic"] as! String
                        var topic: SSTopic?
                        for sstopic in SSStorage.sharedInstance.getTopicsForSubject(subject: subject!) {
                            if sstopic.name == topicName {
                                topic = sstopic
                            }
                        }
                        
//                        let skillswapState = SubjectState.active
                        
//                        let sssubject = SSSubject(id: "na", name: subject, state: skillswapState, colorHex: "8A8FFC")
//                        
//                        let sstopic = SSTopic(id: "na", name: topicName, subject: sssubject, state: TopicState.active)
                        
                        var meetupState: MeetupState = MeetupState.active
                        
                        switch state {
                        case 2:
                            meetupState = MeetupState.matched
                        case 3:
                            meetupState = MeetupState.canceled
                        case 4:
                            meetupState = MeetupState.expired
                        case 5:
                            meetupState = MeetupState.finished
                        default:
                            meetupState = .canceled
                        }
                        
                        let meetup = SSMeetup(id: "", student: ssStudent, summary: summary, details: details, location: location!, topic: topic!, timeExchange: timeExchange)
                        meetup.state = meetupState
                        meetup.createdDate = date
                        var insert = true
                        if(plocation != nil && meetup.location?.address != plocation?.address){
                            insert = false
                        }
                        if (psubject != nil && meetup.topic?.subject?.name != psubject?.name) {
                            insert = false
                        }
                        if insert {
                            meetups.append(meetup)
                        }
                    }
                    completion(true, meetups)
                } else {
                    let error = json?["error"] as? [String: Any]
                    print("\(error)")
                    completion(true, SSStorage.sharedInstance.getAllMeetups())
                }
        }
//        completion(true, SSStorage.sharedInstance.getAllMeetups())
    }
    
    class func getUsersMeetups(astate: Int, completion: @escaping (_ success: Bool, _ subjects: Array<SSMeetup>?)->()) {
        
        var parameters: Parameters = [
            "teacher": SSCurrentUser.sharedInstance.user?.phone! as Any,
            "state": astate
        ]
        
        Alamofire.request("\(url)/getMeetups", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
                let success = json?["success"] as? Bool
                var meetups: Array<SSMeetup> = []
                if (success == true) {
                    let data = json?["data"] as? Array<[String: Any]>
                    for meetupJson in data! {
                        
                        //summary and details
                        let summary = meetupJson["summary"] as! String
                        let details = meetupJson["details"] as! String
                        
                        // teacher { name, phone }
                        //                        let teacher = meetupJson["teacherInfo"] as! [String: String]?
                        //                        var ssTeacher: SSUser?
                        //                        if teacher != nil{
                        //                            ssTeacher = SSUser(id: "na", name: (teacher?["name"]!)!, phone: (teacher?["phone"]!)!)
                        //                        }
                        
                        // student { name, phone }
                        let studentPhone = meetupJson["student"] as! String
                        let student = meetupJson["studentInfo"] as! [String: Any]
                        let studentName = student["name"]  as! String
                        let ssStudent = SSUser(id: studentPhone, name: studentName, phone: studentPhone)
                        
                        //time and state
                        let timeExchange = meetupJson["timeExchange"] as! Int
                        let state = meetupJson["state"] as! Int
                        
                        //location { name, address }
                        let address = meetupJson["address"] as! String
                        var location: SSLocation?
                        for sslocation in SSStorage.sharedInstance.getLocations() {
                            if sslocation.address == address {
                                location = sslocation
                            }
                        }
                        
                        let createdDate = meetupJson["createddate"] as! TimeInterval
                        let date = NSDate.init(timeIntervalSinceReferenceDate: createdDate)
                        
                        //                        let topicInfo = meetupJson["topicInfo"] as! [String: Any]
                        
                        let subjectName = meetupJson["subject"] as! String
                        var subject: SSSubject?
                        for sssubject in SSStorage.sharedInstance.getAllSubjects() {
                            if sssubject.name == subjectName {
                                subject = sssubject
                            }
                        }
                        
                        //topic { name }
                        let topicName = meetupJson["topic"] as! String
                        var topic: SSTopic?
                        for sstopic in SSStorage.sharedInstance.getTopicsForSubject(subject: subject!) {
                            if sstopic.name == topicName {
                                topic = sstopic
                            }
                        }
                        
                        //                        let skillswapState = SubjectState.active
                        
                        //                        let sssubject = SSSubject(id: "na", name: subject, state: skillswapState, colorHex: "8A8FFC")
                        //
                        //                        let sstopic = SSTopic(id: "na", name: topicName, subject: sssubject, state: TopicState.active)
                        
                        var meetupState: MeetupState = MeetupState.active
                        
                        switch state {
                        case 2:
                            meetupState = MeetupState.matched
                        case 3:
                            meetupState = MeetupState.canceled
                        case 4:
                            meetupState = MeetupState.expired
                        case 5:
                            meetupState = MeetupState.finished
                        default:
                            meetupState = .canceled
                        }
                        
                        let meetup = SSMeetup(id: "", student: ssStudent, summary: summary, details: details, location: location!, topic: topic!, timeExchange: timeExchange)
                        meetup.state = meetupState
                        meetup.createdDate = date
                        meetups.append(meetup)
                    }
                    completion(true, meetups)
                } else {
                    let error = json?["error"] as? [String: Any]
                    print("\(error)")
                    completion(true, SSStorage.sharedInstance.getAllMeetups())
                }
        }
        //        completion(true, SSStorage.sharedInstance.getAllMeetups())
    }
    
    class func checkWaitingMeetups(completion: @escaping (_ success: Bool, _ subjects: Array<SSMeetup>?)->()) {
        var parameters: Parameters
        if let phone = SSCurrentUser.sharedInstance.user?.phone {
            parameters = [
                "student": phone,
                "state": 1
            ]
        } else {
            return
        }

        
        Alamofire.request("\(url)/getMeetups", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
                let success = json?["success"] as? Bool
                var meetups: Array<SSMeetup> = []
                if (success == true) {
                    let data = json?["data"] as? Array<[String: Any]>
                    for meetupJson in data! {
                        
                        //summary and details
                        let summary = meetupJson["summary"] as! String
                        let details = meetupJson["details"] as! String
                        
                        // teacher { name, phone }
                        //                        let teacher = meetupJson["teacherInfo"] as! [String: String]?
                        //                        var ssTeacher: SSUser?
                        //                        if teacher != nil{
                        //                            ssTeacher = SSUser(id: "na", name: (teacher?["name"]!)!, phone: (teacher?["phone"]!)!)
                        //                        }
                        
                        // student { name, phone }
                        let studentPhone = meetupJson["student"] as! String
                        let student = meetupJson["studentInfo"] as! [String: Any]
                        let studentName = student["name"]  as! String
                        let ssStudent = SSUser(id: studentPhone, name: studentName, phone: studentPhone)
                        
                        //time and state
                        let timeExchange = meetupJson["timeExchange"] as! Int
                        let state = meetupJson["state"] as! Int
                        
                        //location { name, address }
                        let address = meetupJson["address"] as! String
                        var location: SSLocation?
                        for sslocation in SSStorage.sharedInstance.getLocations() {
                            if sslocation.address == address {
                                location = sslocation
                            }
                        }
                        
                        let createdDate = meetupJson["createddate"] as! TimeInterval
                        let date = NSDate.init(timeIntervalSinceReferenceDate: createdDate)
                        
                        //                        let topicInfo = meetupJson["topicInfo"] as! [String: Any]
                        
                        let subjectName = meetupJson["subject"] as! String
                        var subject: SSSubject?
                        for sssubject in SSStorage.sharedInstance.getAllSubjects() {
                            if sssubject.name == subjectName {
                                subject = sssubject
                            }
                        }
                        
                        //topic { name }
                        let topicName = meetupJson["topic"] as! String
                        var topic: SSTopic?
                        for sstopic in SSStorage.sharedInstance.getTopicsForSubject(subject: subject!) {
                            if sstopic.name == topicName {
                                topic = sstopic
                            }
                        }
                        
                        //                        let skillswapState = SubjectState.active
                        
                        //                        let sssubject = SSSubject(id: "na", name: subject, state: skillswapState, colorHex: "8A8FFC")
                        //
                        //                        let sstopic = SSTopic(id: "na", name: topicName, subject: sssubject, state: TopicState.active)
                        
                        var meetupState: MeetupState = MeetupState.active
                        
                        switch state {
                        case 2:
                            meetupState = MeetupState.matched
                        case 3:
                            meetupState = MeetupState.canceled
                        case 4:
                            meetupState = MeetupState.expired
                        case 5:
                            meetupState = MeetupState.finished
                        default:
                            meetupState = .canceled
                        }
                        
                        let meetup = SSMeetup(id: "", student: ssStudent, summary: summary, details: details, location: location!, topic: topic!, timeExchange: timeExchange)
                        meetup.state = meetupState
                        meetup.createdDate = date
                        meetups.append(meetup)
                    }
                    completion(true, meetups)
                } else {
                    let error = json?["error"] as? [String: Any]
                    print("\(error)")
                    completion(true, SSStorage.sharedInstance.getAllMeetups())
                }
        }
        //        completion(true, SSStorage.sharedInstance.getAllMeetups())
    }
    
    class func checkMatchedMeetups(completion: @escaping (_ success: Bool, _ subjects: Array<SSMeetup>?)->()) {
        var parameters: Parameters
        if let phone = SSCurrentUser.sharedInstance.user?.phone {
            parameters = [
                "student": phone,
                "state": 2
            ]
        } else {
            return
        }
        
        
        Alamofire.request("\(url)/getMeetups", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
                let success = json?["success"] as? Bool
                var meetups: Array<SSMeetup> = []
                if (success == true) {
                    let data = json?["data"] as? Array<[String: Any]>
                    for meetupJson in data! {
                        
                        //summary and details
                        let summary = meetupJson["summary"] as! String
                        let details = meetupJson["details"] as! String
                        
                        // teacher { name, phone }
                        //                        let teacher = meetupJson["teacherInfo"] as! [String: String]?
                        //                        var ssTeacher: SSUser?
                        //                        if teacher != nil{
                        //                            ssTeacher = SSUser(id: "na", name: (teacher?["name"]!)!, phone: (teacher?["phone"]!)!)
                        //                        }
                        
                        // student { name, phone }
                        let studentPhone = meetupJson["student"] as! String
                        let student = meetupJson["studentInfo"] as! [String: Any]
                        let studentName = student["name"]  as! String
                        let ssStudent = SSUser(id: studentPhone, name: studentName, phone: studentPhone)
                        
                        //time and state
                        let timeExchange = meetupJson["timeExchange"] as! Int
                        let state = meetupJson["state"] as! Int
                        
                        //location { name, address }
                        let address = meetupJson["address"] as! String
                        var location: SSLocation?
                        for sslocation in SSStorage.sharedInstance.getLocations() {
                            if sslocation.address == address {
                                location = sslocation
                            }
                        }
                        
                        let createdDate = meetupJson["createddate"] as! TimeInterval
                        let date = NSDate.init(timeIntervalSinceReferenceDate: createdDate)
                        
                        //                        let topicInfo = meetupJson["topicInfo"] as! [String: Any]
                        
                        let subjectName = meetupJson["subject"] as! String
                        var subject: SSSubject?
                        for sssubject in SSStorage.sharedInstance.getAllSubjects() {
                            if sssubject.name == subjectName {
                                subject = sssubject
                            }
                        }
                        
                        //topic { name }
                        let topicName = meetupJson["topic"] as! String
                        var topic: SSTopic?
                        for sstopic in SSStorage.sharedInstance.getTopicsForSubject(subject: subject!) {
                            if sstopic.name == topicName {
                                topic = sstopic
                            }
                        }
                        
                        //                        let skillswapState = SubjectState.active
                        
                        //                        let sssubject = SSSubject(id: "na", name: subject, state: skillswapState, colorHex: "8A8FFC")
                        //
                        //                        let sstopic = SSTopic(id: "na", name: topicName, subject: sssubject, state: TopicState.active)
                        
                        var meetupState: MeetupState = MeetupState.active
                        
                        switch state {
                        case 2:
                            meetupState = MeetupState.matched
                        case 3:
                            meetupState = MeetupState.canceled
                        case 4:
                            meetupState = MeetupState.expired
                        case 5:
                            meetupState = MeetupState.finished
                        default:
                            meetupState = .canceled
                        }
                        
                        let meetup = SSMeetup(id: "", student: ssStudent, summary: summary, details: details, location: location!, topic: topic!, timeExchange: timeExchange)
                        meetup.state = meetupState
                        meetup.createdDate = date
                        meetups.append(meetup)
                    }
                    completion(true, meetups)
                } else {
                    let error = json?["error"] as? [String: Any]
                    print("\(error)")
                    completion(true, SSStorage.sharedInstance.getAllMeetups())
                }
        }
        //        completion(true, SSStorage.sharedInstance.getAllMeetups())
    }

    
    class func postMeetup(meetup: SSMeetup, completion: @escaping (_ success: Bool)->()) {
        let parameters: Parameters = [
            "student": meetup.student!.phone!,
            "summary": meetup.summary!,
            "details": meetup.details!,
            "address":meetup.location!.address! ,
            "topic":meetup.topic!.name!,
            "subject":meetup.topic?.subject?.name! as Any,
            "state": 1,
            "timeExchange": meetup.timeExchange!
        ]
        Alamofire.request("\(url)/postMeetup", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print("\(json!)")
                let success = json?["success"] as? Bool
                if (success == true) {
                    let createdDate = json?["createdDate"] as? TimeInterval
                    let date = NSDate.init(timeIntervalSinceReferenceDate: createdDate!)
                    SSCurrentUser.sharedInstance.currentMeetupPost?.createdDate = date
                    completion(true)
                } else {
                    let error = json?["error"] as? [String: Any]
                    print("\(error)")
                    completion(false)
                }
        }
    }
    
    class func cancelMeetup(completion: @escaping (_ success: Bool)->()) {
        let parameters: Parameters = [
            "phone": SSCurrentUser.sharedInstance.user?.phone! as Any,
            "createdDate": (SSCurrentUser.sharedInstance.currentMeetupPost?.createdDate?.timeIntervalSinceReferenceDate)!,
            "state": 3
        ]
        Alamofire.request("\(url)/cancelMeetup", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                let success = json?["success"] as? Bool
                if (success == true) {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    class func getUserInfo(completion: @escaping (_ success: Bool)->()) {
        let parameters: Parameters = [
            "phone": SSCurrentUser.sharedInstance.user?.phone! as Any,
        ]
        Alamofire.request("\(url)/getUser", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
                let success = json?["success"] as? Bool
                if (success == true) {
                    let data = json?["data"] as? [String: Any]
                    let time = data?["timebank"] as? Int
                    SSCurrentUser.sharedInstance.user?.time = time
                    if let timeString = NumberFormatter().string(from: NSNumber.init(value: time!)) {
                        KeychainSwift().set(timeString, forKey: TIME_BANK_KEY)
                    }
                    
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    class func acceptMeetup(meetup: SSMeetup, completion: @escaping (_ success: Bool)->()) {
        let parameters: Parameters = [
            "teacher": SSCurrentUser.sharedInstance.user?.phone! as Any,
            "student": meetup.student?.phone! as Any,
            "createdDate": (meetup.createdDate?.timeIntervalSinceReferenceDate)!,
            "state": 2
        ]
        Alamofire.request("\(url)/acceptMeetup", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                let success = json?["success"] as? Bool
                if (success == true) {
                    completion(true)
                } else {
                    completion(false)
                }
        }
        completion(true)
    }
    
    class func checkMeetup(meetup: SSMeetup, completion: @escaping (_ success: Bool, _ state: MeetupState?)->()) {
        let parameters: Parameters = [
            "student": meetup.student?.phone! as Any,
            "createdDate": (meetup.createdDate?.timeIntervalSinceReferenceDate)!,
        ]
        Alamofire.request("\(url)/checkMeetup", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
                let success = json?["success"] as? Bool
                if (success == true) {
                    let data = json?["data"] as? [String: Any]
                    let state = data?["state"] as? Int
                    
                    var meetupState: MeetupState = MeetupState.active
                    
                    switch state! {
                    case 2:
                        meetupState = MeetupState.matched
                    case 3:
                        meetupState = MeetupState.canceled
                    case 4:
                        meetupState = MeetupState.expired
                    case 5:
                        meetupState = MeetupState.finished
                    default:
                        meetupState = .canceled
                    }
                    
                    if meetupState == .matched {
                        let teachJson = data?["teacherinfo"] as? [String: Any]
                        let teacherName = teachJson?["name"] as? String
                        let teacherPhone = teachJson?["phone"] as? String
                        let ssteacher = SSUser(id: "na", name:teacherName! , phone: teacherPhone!)
                        meetup.teacher = ssteacher
                    }
                    
                    completion(true, meetupState)
                } else {
                    completion(false, nil)
                }
        }
    }
    
    class func payMeetup(exchange: Int, meetup: SSMeetup, completion: @escaping (_ success: Bool)->()){
        let parameters: Parameters = [
            "student": SSCurrentUser.sharedInstance.user?.phone as Any,
            "teacher": meetup.teacher?.phone as Any,
            "createdDate": meetup.createdDate?.timeIntervalSinceReferenceDate as Any,
            "state": 5,
            "exchange": exchange
        ]
        Alamofire.request("\(url)/payMeetup", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                let success = json?["success"] as? Bool
                if (success == true) {
                    completion(true)
                } else {
                    completion(false)
                }
        }
    }
    
    class func getHistory(completion: @escaping (_ success: Bool, _ subjects: Array<SSMeetup>?)->()) {
        
        completion(true, SSStorage.sharedInstance.getHistory())
    }
}

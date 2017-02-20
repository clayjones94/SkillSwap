//
//  SSDatabase.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/6/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import Alamofire

let url = "https://skillswapserver.herokuapp.com"

class SSDatabase {
    
    class func registerUser (user: SSUser, password: String, completion: @escaping (_ success: Bool, _ user: SSUser?)->()) {
        let parameters: Parameters = [
            "phone": user.phone!,
            "name": user.name!,
            "photo": "/profile",
            "major": "Computer Science",
            "password": password
        ]
        Alamofire.request("\(url)/register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print(json)
//                let success = json?["success"] as? Bool
                if (json?["phone"] as? String) != nil {
                    let phone = json?["phone"] as? String
                    let name = json?["name"] as? String
                    let user = SSUser(id: phone!, name: name!, phone: phone!)
                    user.time = json?["timebank"] as? Int
                    completion(true, user)
                } else {
                    completion(false, nil)
                }
        }
    }
    
    class func loginUser(user: SSUser, password: String, completion: @escaping (_ success: Bool, _ user: SSUser?)->()) {
        let parameters: Parameters = [
            "phone": user.phone!,
            "password": password
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
                    user.time = data?["timebank"] as? Int
                    completion(true, user)
                } else {
                    completion(false, nil)
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
        
        var parameters: Parameters = [
            "state": 1
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
                        let student = meetupJson["studentInfo"] as! [String: String]
                        let studentName = student["name"]
                        let ssStudent = SSUser(id: studentPhone, name: studentName!, phone: studentPhone)
                        
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
    
    class func postMeetup(meetup: SSMeetup, completion: @escaping (_ success: Bool)->()) {
        let parameters: Parameters = [
            "student": meetup.student!.phone!,
            "summary": meetup.summary!,
            "details": meetup.details!,
            "address":meetup.location!.address! ,
            "topic":meetup.topic!.name!,
            "subject":meetup.topic?.subject?.name!,
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
                    completion(true, meetupState)
                } else {
                    completion(false, nil)
                }
        }
    }
    
    class func payMeetup(meetup: SSMeetup, withExchange exchange: Int, completion: @escaping (_ success: Bool)->()){
        let parameters: Parameters = [
            "phone": SSCurrentUser.sharedInstance.user?.phone as Any,
            "createdDate": (SSCurrentUser.sharedInstance.currentMeetupPost?.createdDate?.timeIntervalSinceReferenceDate)!,
            "state": 4
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

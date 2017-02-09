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
    
    class func registerUser (user: SSUser, completion: @escaping (_ success: Bool, _ user: SSUser)->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            completion(true, SSStorage.sharedInstance.currentUser)
        })
    }
    
    class func loginUser(user: SSUser?, completion: @escaping (_ success: Bool, _ user: SSUser?)->()) {
        let parameters: Parameters = [
            "phone": "8318219707",
            "password": "password1"
        ]
        Alamofire.request("\(url)/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                let success = json?["success"] as? Bool
                if (success == true) {
                    let data = json?["data"] as? [String: Any]
                    let phone = data?["phone"] as? String
                    let name = data?["name"] as? String
                    let user = SSUser(id: phone!, name: name!, phone: phone!)
                    
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
    
    class func getAllMeetups(completion: @escaping (_ success: Bool, _ subjects: Array<SSMeetup>?)->()) {
        
//        let parameters: Parameters = [
//            "state": 1
//        ]
//        Alamofire.request("\(url)/getMeetups", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
//            .responseJSON { response in
//                let json = response.result.value as? [String: Any]
//                print("\(response.result.value)")
//                let success = json?["success"] as? Bool
//                if (success == true) {
//                    let data = json?["data"] as? Array<[String: Any]>
//                    for meetupJson in data! {
//                        let summary = meetupJson["summary"] as! String
//                        let details = meetupJson["details"] as! String
//                        let teacher = meetupJson["teacher"] as! [String: String]?
//                        var ssTeacher: SSUser?
//                        if teacher != nil{
//                            ssTeacher = SSUser(id: (teacher?["phone"]!)!, name: (teacher?["phone"]!)!, phone: (teacher?["phone"]!)!)
//                        }
//                        let student = meetupJson["student"] as! [String: String]
//                        let ssStudent = SSUser(id: student["phone"]!, name: student["name"]!, phone: student["phone"]!)
//                        let timeExchange = meetupJson["timeexchange"] as! Int
//                        let state = meetupJson["state"] as! Int
//                        let location = meetupJson["location"] as! [String: String]?
//                        let ssLocation = SSLocation(name: (location?["name"]!)!, address: (location?["address"]!)!)
//                        
//                        var meetupState: MeetupState = MeetupState.active
//                        
//                        switch state {
//                        case 2:
//                            meetupState = MeetupState.matched
//                        case 3:
//                            meetupState = MeetupState.canceled
//                        case 4:
//                            meetupState = MeetupState.expired
//                        case 5:
//                            meetupState = MeetupState.finished
//                        }
//                        
//                        let meetup = SSMeetup(id: "", student: ssStudent, summary: summary, details: details, location: ssLocation, topic: SSTopic(, timeExchange: timeExchange)
//                    }
//                } else {
//                    let error = json?["error"] as? [String: Any]
//                    print("\(error)")
//                    completion(false, nil)
//                }
//        }
        completion(true, SSStorage.sharedInstance.getAllMeetups())
    }
    
    class func postMeetup(meetup: SSMeetup, completion: @escaping (_ success: Bool)->()) {
        let parameters: Parameters = [
            "student": meetup.student!.phone!,
            "summary": meetup.summary!,
            "details": meetup.details!,
            "address":meetup.location!.address! ,
            "topic":meetup.topic!.name!,
            "state": 1,
            "timeExchange": meetup.timeExchange!
        ]
        Alamofire.request("\(url)/postMeetup", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                let json = response.result.value as? [String: Any]
                print("\(json!)")
                let success = json?["success"] as? Bool
                if (success == true) {
                    let data = json?["data"] as? [String: Any]
                    print("\(data)")
                    
                    completion(true)
                } else {
                    let error = json?["error"] as? [String: Any]
                    print("\(error)")
                    completion(false)
                }
        }
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

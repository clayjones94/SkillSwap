//
//  SSStorage.swift
//  SkillSwap
//
//  Created by Clay Jones on 2/7/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit

class SSStorage: NSObject {
    
    static let sharedInstance = SSStorage()
    
    let currentUser = SSUser(id: "sadf", name: "Clay Jones", phone: "858-472-3180")
    
    let math = SSSubject(id: "math", name: "Math", state: SubjectState.active, colorHex: "#8A8FFC")
    let computerScience = SSSubject(id: "compsci", name: "Computer Science", state: SubjectState.active, colorHex: "#FD8BB5")
    let writing = SSSubject(id: "writing", name: "Writing", state: SubjectState.active, colorHex: "#FEDB8E")
    let physics = SSSubject(id: "physics", name: "Physics", state: SubjectState.active, colorHex: "#92D4F5")
    let chemistry = SSSubject(id: "chem", name: "Chemistry", state: SubjectState.active, colorHex: "#75DF98")
    let athletics = SSSubject(id: "athletics", name: "Athletics", state: SubjectState.active, colorHex: "#F3A273")
    let music = SSSubject(id: "music", name: "Music", state: SubjectState.active, colorHex: "#EB6E7B")
    let interviewPrep = SSSubject(id: "ushistory", name: "Interview Prep", state: SubjectState.active, colorHex: "#60D0E3")
    let art = SSSubject(id: "art", name: "Art", state: SubjectState.active, colorHex: "#D697DB")
    
    let user1 = SSUser(id: "1", name: "Season Remsen", phone: "858-472-3180")
    let user2 = SSUser(id: "2", name: "Brenton Pettry", phone: "858-472-3180")
    let user3 = SSUser(id: "3", name: "Olevia Albright", phone: "858-472-3180")
    let user4 = SSUser(id: "4", name: "Alexandria Benedetto", phone: "858-472-3180")
    let user5 = SSUser(id: "5", name: "Esmeralda Poindexter", phone: "858-472-3180")
    let user6 = SSUser(id: "6", name: "Kayleen Finlayson", phone: "858-472-3180")
    let user7 = SSUser(id: "7", name: "Gladis Gullette", phone: "858-472-3180")
    let user8 = SSUser(id: "8", name: "Leonida Elledge", phone: "858-472-3180")
    let user9 = SSUser(id: "9", name: "Jolyn Lorence", phone: "858-472-3180")
    
    let loc1 = SSLocation(name: "Tressider Union", address: "address1")
    let loc2 = SSLocation(name: "Green Library", address: "address2")
    let loc3 = SSLocation(name: "Huang Basement", address: "address3")
    let loc4 = SSLocation(name: "Old Union", address: "address4")
    
    override init() {
        math.image = #imageLiteral(resourceName: "math_icon")
        computerScience.image = #imageLiteral(resourceName: "comp_sci_icon")
        writing.image = #imageLiteral(resourceName: "Writing")
        physics.image = #imageLiteral(resourceName: "physics_icon")
        chemistry.image = #imageLiteral(resourceName: "chem_icon")
        athletics.image = #imageLiteral(resourceName: "sports_icon")
        music.image = #imageLiteral(resourceName: "music_icon")
        interviewPrep.image = #imageLiteral(resourceName: "history_icon")
        art.image = #imageLiteral(resourceName: "art_icon")
    }
    
    func getTopicsForSubject(subject: SSSubject) -> Array<SSTopic> {
        if subject.id == computerScience.id {
            let cs106A = SSTopic(id: "cs106a", name: "CS 106A", subject: computerScience, state: TopicState.active)
            let cs106B = SSTopic(id: "cs106b", name: "CS 106B", subject: computerScience, state: TopicState.active)
            let cs103 = SSTopic(id: "cs103", name: "CS 103", subject: computerScience, state: TopicState.active)
            let cs105 = SSTopic(id: "cs105", name: "CS 105", subject: computerScience, state: TopicState.active)
            let cs109 = SSTopic(id: "cs109", name: "CS 109", subject: computerScience, state: TopicState.active)
            return [cs106A, cs106B, cs103, cs105, cs109]
        } else if subject.id == math.id {
            let topic1 = SSTopic(id: "Math 19", name: "Math 19", subject: math, state: TopicState.active)
            let topic2 = SSTopic(id: "Math 20", name: "Math 20", subject: math, state: TopicState.active)
            let topic3 = SSTopic(id: "cs103", name: "Math 51", subject: math, state: TopicState.active)
            let topic4 = SSTopic(id: "cs105", name: "Math 53", subject: math, state: TopicState.active)
            let topic5 = SSTopic(id: "cs109", name: "CME 100", subject: math, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        } else if subject.id == writing.id {
            let topic1 = SSTopic(id: "Grammar", name: "Grammar", subject: math, state: TopicState.active)
            let topic2 = SSTopic(id: "Creative Writing", name: "Creative Writing", subject: math, state: TopicState.active)
            let topic3 = SSTopic(id: "Poetry", name: "Poetry", subject: math, state: TopicState.active)
            let topic4 = SSTopic(id: "Haiku", name: "Haiku", subject: math, state: TopicState.active)
            let topic5 = SSTopic(id: "Syntax", name: "Syntax", subject: math, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        } else if subject.id == physics.id {
            let topic1 = SSTopic(id: "Math 19", name: "Math 19", subject: writing, state: TopicState.active)
            let topic2 = SSTopic(id: "Math 20", name: "Math 20", subject: writing, state: TopicState.active)
            let topic3 = SSTopic(id: "cs103", name: "Math 51", subject: writing, state: TopicState.active)
            let topic4 = SSTopic(id: "cs105", name: "Math 53", subject: writing, state: TopicState.active)
            let topic5 = SSTopic(id: "cs109", name: "CME 100", subject: writing, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        } else if subject.id == chemistry.id {
            let topic1 = SSTopic(id: "Math 19", name: "Chem 31", subject: chemistry, state: TopicState.active)
            let topic2 = SSTopic(id: "Math 20", name: "Chem 45", subject: chemistry, state: TopicState.active)
            let topic3 = SSTopic(id: "cs103", name: "Organic Chemistry", subject: chemistry, state: TopicState.active)
            let topic4 = SSTopic(id: "cs105", name: "Chem 191", subject: chemistry, state: TopicState.active)
            let topic5 = SSTopic(id: "cs109", name: "Moles", subject: chemistry, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        } else if subject.id == athletics.id {
            let topic1 = SSTopic(id: "Math 19", name: "Volleyball", subject: athletics, state: TopicState.active)
            let topic2 = SSTopic(id: "Math 20", name: "Baseball", subject: athletics, state: TopicState.active)
            let topic3 = SSTopic(id: "cs103", name: "Ballroom Dance", subject: athletics, state: TopicState.active)
            let topic4 = SSTopic(id: "cs105", name: "Self Defense", subject: athletics, state: TopicState.active)
            let topic5 = SSTopic(id: "cs109", name: "Basketball", subject: athletics, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        } else if subject.id == music.id {
            let topic1 = SSTopic(id: "Math 19", name: "Guitar", subject: music, state: TopicState.active)
            let topic2 = SSTopic(id: "Math 20", name: "Piano", subject: music, state: TopicState.active)
            let topic3 = SSTopic(id: "cs103", name: "Singing", subject: music, state: TopicState.active)
            let topic4 = SSTopic(id: "cs105", name: "Viola", subject: music, state: TopicState.active)
            let topic5 = SSTopic(id: "cs109", name: "Rapping", subject: music, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        } else if subject.id == art.id {
            let topic1 = SSTopic(id: "Math 19", name: "Watercolors", subject: art, state: TopicState.active)
            let topic2 = SSTopic(id: "Math 20", name: "Painting", subject: art, state: TopicState.active)
            let topic3 = SSTopic(id: "cs103", name: "Drawing", subject: art, state: TopicState.active)
            let topic4 = SSTopic(id: "cs105", name: "Graphical Design", subject: art, state: TopicState.active)
            let topic5 = SSTopic(id: "cs109", name: "Ceramics", subject: art, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        }  else if subject.id == interviewPrep.id {
            let topic1 = SSTopic(id: "Math 19", name: "Computer Science", subject: interviewPrep, state: TopicState.active)
            let topic2 = SSTopic(id: "Math 20", name: "Consulting", subject: interviewPrep, state: TopicState.active)
            let topic3 = SSTopic(id: "cs103", name: "Finance", subject: interviewPrep, state: TopicState.active)
            let topic4 = SSTopic(id: "cs105", name: "Medical", subject: interviewPrep, state: TopicState.active)
            let topic5 = SSTopic(id: "cs109", name: "Education", subject: interviewPrep, state: TopicState.active)
            return [topic1, topic2, topic3, topic4, topic5]
        }
        return []
    }
    
    func getAllSubjects() -> Array<SSSubject> {
        return [computerScience, math, writing, physics, chemistry, athletics, music, interviewPrep, art]
    }
    
    func getAllUsers() -> Array<SSUser> {
        return [user1,user2, user3, user4, user5, user6, user7, user8, user9]
    }
    
    func getLocations() -> Array<SSLocation> {
        return [loc1, loc2, loc3, loc4]
    }
    
    func getAllMeetups() -> Array<SSMeetup>{
        let meetup1 = SSMeetup(id: "1", student: user1, summary: "Need Karel Help", details: "Please I really need help on this one assignment associated with this specific topic", location: loc1, topic: getTopicsForSubject(subject: computerScience)[0], timeExchange: 40)
        let meetup2 = SSMeetup(id: "2", student: user2, summary: "Recursive Backtracking", details: "Please I really need help on this one assignment associated with this specific topic", location: loc2, topic: getTopicsForSubject(subject: math)[1], timeExchange: 30)
        let meetup3 = SSMeetup(id: "3", student: user3, summary: "Solving NP Problem", details: "Please I really need help on this one assignment associated with this specific topic", location: loc3, topic: getTopicsForSubject(subject: computerScience)[2], timeExchange: 15)
        let meetup4 = SSMeetup(id: "4", student: user4, summary: "For Loops", details: "Please I really need help on this one assignment associated with this specific topic", location: loc1, topic: getTopicsForSubject(subject: math)[3], timeExchange: 10)
        let meetup5 = SSMeetup(id: "5", student: user5, summary: "Combinations", details: "Please I really need help on this one assignment associated with this specific topic", location: loc1, topic: getTopicsForSubject(subject: computerScience)[4], timeExchange: 30)
        let meetup6 = SSMeetup(id: "6", student: user6, summary: "Boggle Recursion", details: "Please I really need help on this one assignment associated with this specific topic", location: loc4, topic: getTopicsForSubject(subject: computerScience)[1], timeExchange: 20)
        return [meetup1, meetup2, meetup3, meetup4, meetup5, meetup6]
    }
}

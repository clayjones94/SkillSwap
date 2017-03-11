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
            let cs1 = SSTopic(id: "cs106a", name: "CS 106A", subject: computerScience, state: TopicState.active)
            let cs2 = SSTopic(id: "cs106b", name: "CS 106B", subject: computerScience, state: TopicState.active)
            let cs3 = SSTopic(id: "cs103", name: "CS 103", subject: computerScience, state: TopicState.active)
            let cs4 = SSTopic(id: "cs105", name: "CS 105", subject: computerScience, state: TopicState.active)
            let cs5 = SSTopic(id: "cs109", name: "CS 109", subject: computerScience, state: TopicState.active)
            let cs6 = SSTopic(id: "cs107", name: "CS 107", subject: computerScience, state: TopicState.active)
            let cs7 = SSTopic(id: "python", name: "Python", subject: computerScience, state: TopicState.active)
            let cs8 = SSTopic(id: "matlab", name: "Matlab", subject: computerScience, state: TopicState.active)
            let cs9 = SSTopic(id: "runtime", name: "Runtime", subject: computerScience, state: TopicState.active)
            let cs10 = SSTopic(id: "basics", name: "Basics", subject: computerScience, state: TopicState.active)
            let cs11 = SSTopic(id: "csother", name: "Other", subject: computerScience, state: TopicState.active)
            return [cs1, cs2, cs3, cs4, cs5,cs6, cs7, cs8, cs9, cs10, cs11]
        } else if subject.id == math.id {
            let m1 = SSTopic(id: "math19", name: "Math 19", subject: math, state: TopicState.active)
            let m2 = SSTopic(id: "math20", name: "Math 20", subject: math, state: TopicState.active)
            let m3 = SSTopic(id: "math51", name: "Math 51", subject: math, state: TopicState.active)
            let m4 = SSTopic(id: "math53", name: "Math 53", subject: math, state: TopicState.active)
            let m5 = SSTopic(id: "cme100", name: "CME 100", subject: math, state: TopicState.active)
            let m6 = SSTopic(id: "math52", name: "Math 52", subject: math, state: TopicState.active)
            let m7 = SSTopic(id: "cme102", name: "CME 102", subject: math, state: TopicState.active)
            let m8 = SSTopic(id: "integration", name: "Integration", subject: math, state: TopicState.active)
            let m9 = SSTopic(id: "matrices", name: "Matrices", subject: math, state: TopicState.active)
            let m10 = SSTopic(id: "derivatives", name: "Derivatives", subject: math, state: TopicState.active)
            let m11 = SSTopic(id: "mathother", name: "Other", subject: math, state: TopicState.active)
            return [m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11]
        } else if subject.id == writing.id {
            let w1 = SSTopic(id: "grammar", name: "Grammar", subject: writing, state: TopicState.active)
            let w2 = SSTopic(id: "creativewriting", name: "Creative Writing", subject: writing, state: TopicState.active)
            let w3 = SSTopic(id: "poetry", name: "Poetry", subject: writing, state: TopicState.active)
            let w4 = SSTopic(id: "oral", name: "Oral Presentation", subject: writing, state: TopicState.active)
            let w5 = SSTopic(id: "syntax", name: "Syntax", subject: writing, state: TopicState.active)
            let w6 = SSTopic(id: "pwr", name: "PWR", subject: writing, state: TopicState.active)
            let w7 = SSTopic(id: "pwr2", name: "PWR 2", subject: writing, state: TopicState.active)
            let w8 = SSTopic(id: "research", name: "Research", subject: writing, state: TopicState.active)
            let w9 = SSTopic(id: "publishing", name: "Publishing", subject: writing, state: TopicState.active)
            let w10 = SSTopic(id: "wim", name: "WIM", subject: writing, state: TopicState.active)
            let w11 = SSTopic(id: "wother", name: "Other", subject: writing, state: TopicState.active)
            return [w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11]
        } else if subject.id == physics.id {
            let p1 = SSTopic(id: "physics41", name: "Physics 41", subject: physics, state: TopicState.active)
            let p2 = SSTopic(id: "physics43", name: "Physics 43", subject: physics, state: TopicState.active)
            let p3 = SSTopic(id: "physics45", name: "Physics 45", subject: physics, state: TopicState.active)
            let p4 = SSTopic(id: "physics61", name: "Physics 61", subject: physics, state: TopicState.active)
            let p5 = SSTopic(id: "physics63", name: "Physics 63", subject: physics, state: TopicState.active)
            let p6 = SSTopic(id: "physics65", name: "Physics 65", subject: physics, state: TopicState.active)
            let p7 = SSTopic(id: "physics21", name: "Physics 21", subject: physics, state: TopicState.active)
            let p8 = SSTopic(id: "physics23", name: "Physics 23", subject: physics, state: TopicState.active)
            let p9 = SSTopic(id: "physics25", name: "Physics 25", subject: physics, state: TopicState.active)
            let p10 = SSTopic(id: "pother", name: "Other", subject: physics, state: TopicState.active)
            return [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]
        } else if subject.id == chemistry.id {
            let c1 = SSTopic(id: "chem31", name: "Chem 31", subject: chemistry, state: TopicState.active)
            let c2 = SSTopic(id: "chem45", name: "Chem 45", subject: chemistry, state: TopicState.active)
            let c3 = SSTopic(id: "organicchem", name: "Organic Chemistry", subject: chemistry, state: TopicState.active)
            let c4 = SSTopic(id: "chem191", name: "Chem 191", subject: chemistry, state: TopicState.active)
            let c5 = SSTopic(id: "moles", name: "Moles", subject: chemistry, state: TopicState.active)
            let c6 = SSTopic(id: "chem35", name: "Chem 35", subject: chemistry, state: TopicState.active)
            let c7 = SSTopic(id: "acidsbases", name: "Acids/Bases", subject: chemistry, state: TopicState.active)
            let c8 = SSTopic(id: "stereochemistry", name: "Stereochemistry", subject: chemistry, state: TopicState.active)
            let c9 = SSTopic(id: "chem31a", name: "Chem 31A", subject: chemistry, state: TopicState.active)
            let c10 = SSTopic(id: "chem31x", name: "Chem 31X", subject: chemistry, state: TopicState.active)
            let c11 = SSTopic(id: "cother", name: "Other", subject: chemistry, state: TopicState.active)
            return [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11]
        } else if subject.id == athletics.id {
            let ath1 = SSTopic(id: "volleyball", name: "Volleyball", subject: athletics, state: TopicState.active)
            let ath2 = SSTopic(id: "baseball", name: "Baseball", subject: athletics, state: TopicState.active)
            let ath3 = SSTopic(id: "ballroomdance", name: "Ballroom Dance", subject: athletics, state: TopicState.active)
            let ath4 = SSTopic(id: "selfdefense", name: "Self Defense", subject: athletics, state: TopicState.active)
            let ath5 = SSTopic(id: "basketball", name: "Basketball", subject: athletics, state: TopicState.active)
            let ath6 = SSTopic(id: "swimming", name: "Swimming", subject: athletics, state: TopicState.active)
            let ath7 = SSTopic(id: "salsa", name: "Salsa Dancing", subject: athletics, state: TopicState.active)
            let ath8 = SSTopic(id: "parkour", name: "Parkour", subject: athletics, state: TopicState.active)
            let ath9 = SSTopic(id: "socialdance", name: "Social Dance", subject: athletics, state: TopicState.active)
            let ath10 = SSTopic(id: "athother", name: "Other", subject: athletics, state: TopicState.active)
            return [ath1, ath2, ath3, ath4, ath5, ath6, ath7, ath8, ath9, ath10]
        } else if subject.id == music.id {
            let mu1 = SSTopic(id: "guitar", name: "Guitar", subject: music, state: TopicState.active)
            let mu2 = SSTopic(id: "piano", name: "Piano", subject: music, state: TopicState.active)
            let mu3 = SSTopic(id: "singing", name: "Singing", subject: music, state: TopicState.active)
            let mu4 = SSTopic(id: "viola", name: "Viola", subject: music, state: TopicState.active)
            let mu5 = SSTopic(id: "rapping", name: "Rapping", subject: music, state: TopicState.active)
            let mu6 = SSTopic(id: "mutheory", name: "Theory", subject: music, state: TopicState.active)
            let mu7 = SSTopic(id: "violin", name: "Violin", subject: music, state: TopicState.active)
            let mu8 = SSTopic(id: "sheetMusic", name: "Sheet Music", subject: music, state: TopicState.active)
            let mu9 = SSTopic(id: "writingmusic", name: "Writing Music", subject: music, state: TopicState.active)
            let mu10 = SSTopic(id: "ocarina", name: "Ocarina", subject: music, state: TopicState.active)
            let mu11 = SSTopic(id: "muother", name: "Other", subject: music, state: TopicState.active)
            return [mu1, mu2, mu3, mu4, mu5, mu6, mu7, mu8, mu9, mu10, mu11]
        } else if subject.id == art.id {
            let a1 = SSTopic(id: "watercolors", name: "Watercolors", subject: art, state: TopicState.active)
            let a2 = SSTopic(id: "painting", name: "Painting", subject: art, state: TopicState.active)
            let a3 = SSTopic(id: "drawing", name: "Drawing", subject: art, state: TopicState.active)
            let a4 = SSTopic(id: "graphicaldesign", name: "Graphical Design", subject: art, state: TopicState.active)
            let a5 = SSTopic(id: "ceramics", name: "Ceramics", subject: art, state: TopicState.active)
            let a6 = SSTopic(id: "3dmodeling", name: "3D Modeling", subject: art, state: TopicState.active)
            let a7 = SSTopic(id: "animation", name: "Animation", subject: art, state: TopicState.active)
            let a8 = SSTopic(id: "3dprinting", name: "3D Printing", subject: art, state: TopicState.active)
            let a9 = SSTopic(id: "storyboarding", name: "Storyboarding", subject: art, state: TopicState.active)
            let a10 = SSTopic(id: "moviemaking", name: "Movie Making", subject: art, state: TopicState.active)
            let a11 = SSTopic(id: "aother", name: "Other", subject: art, state: TopicState.active)
            return [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11]
        }  else if subject.id == interviewPrep.id {
            let i1 = SSTopic(id: "csinterview", name: "Computer Science", subject: interviewPrep, state: TopicState.active)
            let i2 = SSTopic(id: "consultinginterview", name: "Consulting", subject: interviewPrep, state: TopicState.active)
            let i3 = SSTopic(id: "financeinterview", name: "Finance", subject: interviewPrep, state: TopicState.active)
            let i4 = SSTopic(id: "medicalinterview", name: "Medical", subject: interviewPrep, state: TopicState.active)
            let i5 = SSTopic(id: "educationinterview", name: "Education", subject: interviewPrep, state: TopicState.active)
            let i6 = SSTopic(id: "practiceinterview", name: "Practice Run", subject: interviewPrep, state: TopicState.active)
            let i7 = SSTopic(id: "resumei", name: "Resumes", subject: interviewPrep, state: TopicState.active)
            let i8 = SSTopic(id: "negotiationi", name: "Negotiations", subject: interviewPrep, state: TopicState.active)
            let i9 = SSTopic(id: "sectionleading", name: "Section Leading", subject: interviewPrep, state: TopicState.active)
            let i10 = SSTopic(id: "iother", name: "Other", subject: interviewPrep, state: TopicState.active)
            return [i1, i2, i3, i4, i5, i6, i7, i8, i9, i10]
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
    
    func getHistory() -> Array<SSMeetup>{
        let meetup7 = SSMeetup(id: "7", student: user7, summary: "PWR Grammar Check", details: "I am an international student and need help with editing my PWR paper", location: loc1, topic: getTopicsForSubject(subject: writing)[0], timeExchange: 20)
        let meetup8 = SSMeetup(id: "8", student: user8, summary: "Want to Learn Chords", details: "I just got a guitar and I just want to play Wonderwall", location: loc2, topic: getTopicsForSubject(subject: music)[0], timeExchange: 30)
        let meetup9 = SSMeetup(id: "9", student: user9, summary: "PSET 1 Help", details: "I'm dying send help pls", location: loc3, topic: getTopicsForSubject(subject: math)[0], timeExchange: 45)
        return [meetup7, meetup8, meetup9]
    }
}

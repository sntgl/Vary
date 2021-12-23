//
//  Models.swift
//  Vary
//
//  Created by user207433 on 11/28/21.
//

import Foundation


struct Dictionary: Codable {
    
    let name: String
    let version: Int
    let accessLevel: Int
    var cards: [Card]
    
}

struct Card: Codable {
    
    let id: String
    let name: String
    let version: Int
}



// Saving Teams info to Struct
struct AllTeams: Codable{
    let teamsList: [Team]
}

struct Team: Codable{
    let id: Int
    let name: String
    var score: Int
}





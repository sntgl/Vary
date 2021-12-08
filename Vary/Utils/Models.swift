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
    let cards: [Card]
    
}

struct Card: Codable {
    
    let id: String
    let name: String
    let version: Int
}


enum PassPenalty{
    
    
}


struct GameSettings {
    
    let cardNumber: Int
    let roundTime: Int
    
    enum penaltyForPass{
        case No
        case LosePoints
        case TaskFromPlayers
    }
    let lastCommonWord: Bool
    let beginningTeam: Int // -1 - random
    
    enum chosenDeck{
        case average
        case small
        case big
    }
    
    
}

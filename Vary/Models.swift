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

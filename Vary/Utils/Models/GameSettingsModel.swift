//
//  GameSettingsModel.swift
//  Vary
//
//  Created by user207433 on 12/23/21.
//

import Foundation


struct GameSettings: Codable {
    
    let cardNumber: Int
    let roundTime: Int
    let penaltyForPass: Penalty
    
    enum Penalty: Codable{
        case No
        case LosePoints
        case TaskFromPlayers
        
        init(option: Int) {
               if option == 1 {
                   self = .LosePoints
               } else if option == 2 {
                   self = .TaskFromPlayers
               } else {
                   self = .No
               }
           }
        
    }
    
    let lastCommonWord: Bool
    let beginningTeam: Int // 0 - random
    let chosenDeck : Deck
    
    enum Deck: Codable{
        case medium
        case small
        case large
        
        init(option: String) {
               if option == "Большие" {
                   self = .large
               } else if option == "Маленькие" {
                   self = .small
               } else {
                   self = .medium
               }
           }
        
    }
    
    init(cardNumber: Int, roundTime: Int, penaltyForPass: Int, lastCommonWord: Bool,
         beginningTeam: Int, chosenDeck: String){
        self.cardNumber = cardNumber
        self.roundTime = roundTime
        self.penaltyForPass = Penalty(option: penaltyForPass)
        self.lastCommonWord = lastCommonWord
        self.beginningTeam = beginningTeam
        self.chosenDeck = Deck(option:chosenDeck)
    }
    
    
}

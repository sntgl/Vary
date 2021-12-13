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
    let score: Int
}


struct GameInfo: Codable{
    
    
    let allTeamsInfo: AllTeams
    let cardsForGame: Dictionary
    let gameSettings: GameSettings
    
    var currentRoundTeams: [Team]
    var currentTeam: Int
    var currentRoundType: RoundType
    

    var guessedCardsIndex: [Int]
    var notGuessedCardsIndex: [Int]
    
    mutating func formTeamList() {
        currentRoundTeams = allTeamsInfo.teamsList
        
        if gameSettings.beginningTeam == 0 {
            currentRoundTeams.shuffle()
            return
        } else {
            let firstTeamIndex = gameSettings.beginningTeam - 1
            
            if firstTeamIndex <= (allTeamsInfo.teamsList.count-1){
                let element = currentRoundTeams.remove(at: firstTeamIndex)
                currentRoundTeams.insert(element, at: 0)
            }
        }
      
    

    }
    
    func switchRound(){
        
    }
}



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

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


struct GameInfo: Codable{
    
    
    let allTeamsInfo: AllTeams
    let cardsForGame: Dictionary
    let gameSettings: GameSettings
    
    var currentCards: [Card]
    var currentRoundTeams: [Team]
    var currentTeam: Int
    var currentRoundType: RoundType
    var scoreOfLastRound: Int
    var gameStarted: Bool
    
    
    var guessedCardsIndex: [Int]
    var notGuessedCardsIndex: [Int]
    
    init(allTeamsInfo: AllTeams, cardsForGame:Dictionary, gameSettings: GameSettings){
        self.allTeamsInfo = allTeamsInfo
        self.cardsForGame = cardsForGame
        self.gameSettings = gameSettings
        
        self.currentCards = cardsForGame.cards
        self.currentRoundTeams = []
        self.currentTeam = 0
        self.currentRoundType = .describe
        self.gameStarted = true
        
        self.scoreOfLastRound = 0
        self.guessedCardsIndex = []
        self.notGuessedCardsIndex = []
    }
    
    
    func formTeamList() -> [Team] {
        var resultTeamList = NSArray(array:allTeamsInfo.teamsList, copyItems: true) as! [Team]
//        allTeamsInfo.teamsList.map { $0.copy() }
        
        if gameSettings.beginningTeam == 0 {
            return resultTeamList.shuffled()
        } else {
            let firstTeamIndex = gameSettings.beginningTeam - 1
            
            if firstTeamIndex <= (allTeamsInfo.teamsList.count-1){
                let element = resultTeamList.remove(at: firstTeamIndex)
                resultTeamList.insert(element, at: 0)
                return resultTeamList
            }
        }
      
        return resultTeamList
    
    }
    
    func getNextCard(byIndex index:Int) -> Card?{
        if index < currentCards.count {
            return currentCards[index]
        }
        return nil
        
    }
    
    func getNextRoundType() -> RoundType? {
        switch currentRoundType{
        case .describe:
                return .show
        case .show:
                return .oneWord
        case .oneWord:
                return nil
        case .taskFromPlayers:
                return nil
        }
        
    }
    
    func getNextTeamId() -> Int{
        if self.currentTeam == self.allTeamsInfo.teamsList.count-1 {
            return 0
        }
        return self.currentTeam+1
        
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

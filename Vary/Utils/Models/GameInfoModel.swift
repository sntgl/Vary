//
//  GameInfoModel.swift
//  Vary
//
//  Created by user207433 on 12/23/21.
//

import Foundation


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
    
    
    var guessedCardsIndex: [String]
    var notGuessedCardsIndex: [String]
    
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
    
    func getIndexOfCurrentCardById(by id:String) -> Int?{
        for i in 0..<currentCards.count{
            if id == currentCards[i].id {
                return i
                
            }
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

//
//  SettingsRouter.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import UIKit

final class SettingsRouter {
    weak var viewController: UIViewController?
}

extension SettingsRouter: SettingsRouterInput {
    
    // no use
    func startNewGame() {
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        navController.popViewController(animated: true)
    }
    
    func nextScreen() {
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        
        saveAllGameInfo()
        
        let context: GameScreenContext = GameScreenContext()
        let container: GameScreenContainer = GameScreenContainer.assemble(with: context)
        let gameScreenController: UIViewController = container.viewController
        
        navController.pushViewController(gameScreenController, animated: true)
    }
    
    func saveAllGameInfo() {
        
        //Getting Game Settings
        let settingsViewController: SettingsViewController = viewController as! SettingsViewController
        let userDef = UserDefaultsManager()
//        try? userDef.set(object:settingsViewController.gameSettingsOptions, forKey: UserDefaultKeys.gameSettingsOptionsKey)
        let currentGameSettings = settingsViewController.gameSettingsOptions!
        let teamsInfo = settingsViewController.teamsInfo ?? AllTeams(teamsList: [])
        
        let storageManager = StorageManager(userDefaultManager: userDef)
        let loadedCards = storageManager.loadCards(numberOfCards: currentGameSettings.cardNumber) ?? Dictionary(name: "Not Found", version: 0, accessLevel: 0, cards: [])
    
        
        let gameInfo = GameInfo(allTeamsInfo: teamsInfo, cardsForGame: loadedCards, gameSettings: currentGameSettings, currentRoundTeams: [], currentTeam: 0, currentRoundType: .describe, guessedCardsIndex: [], notGuessedCardsIndex: [])
        
        try? userDef.userDefaults.set(object:gameInfo, forKey: UserDefaultKeys.gameInfo)
        
    }
    
}

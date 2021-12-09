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
        
        //Saving Game Settings
        let settingsViewController: SettingsViewController = viewController as! SettingsViewController
        let userDef = UserDefaultsManager().userDefaults         
        try? userDef.set(object:settingsViewController.gameSettingsOptions, forKey: UserDefaultKeys.gameSettingsOptionsKey)
        
        let testTeam = Team(id: 1, name: "Team 1", score: 0)
        let allTeamsStruct = AllTeams(teamsList: [testTeam])
        
        let context: ScoresContext = ScoresContext()
        let container: ScoresContainer = ScoresContainer.assemble(with: context)
        let scoresViewController: UIViewController = container.viewController
        
        navController.pushViewController(scoresViewController, animated: true)
    }
    
}

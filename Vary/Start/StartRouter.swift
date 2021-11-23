//
//  StartRouter.swift
//  Vary
//
//  Created by Александр Тагилов on 07.11.2021.
//  
//

import UIKit

final class StartRouter {
    weak var viewController: UIViewController?
}

extension StartRouter: StartRouterInput {
    
    func startNewGame() {
//        viewController?.navigationController?.pushViewController(container.viewController, animated: true)
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        let container = TeamsContainer.assemble(with: TeamsContext())
        navController.pushViewController(container.viewController, animated: true)
//        viewController.rootViewController = container
    }
    
    func openSettings(){
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        let context: SettingsContext = SettingsContext()
        let container: SettingsContainer = SettingsContainer.assemble(with: context)
        let settingsViewController: UIViewController = container.viewController
        
        navController.pushViewController(settingsViewController, animated: true)
    }
}

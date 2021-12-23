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
        let navController: UINavigationController = viewController?.navigationController ?? CustomNavigationController(rootViewController: self.viewController!)
        let container = TeamsContainer.assemble(with: TeamsContext())
        navController.pushViewController(container.viewController, animated: true)
    }
    
    func openSettings(){
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        let container = AppSettingsContainer.assemble(with: AppSettingsContext())
        navController.pushViewController(container.viewController, animated: true)
    }
    
    func openHelp(){
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        let container = HelpContainer.assemble(with: HelpContext())
        navController.pushViewController(container.viewController, animated: true)
        
    }
    
}

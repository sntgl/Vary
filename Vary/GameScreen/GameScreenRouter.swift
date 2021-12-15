//
//  GameScreenRouter.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class GameScreenRouter {
    weak var viewController: UIViewController?
}

extension GameScreenRouter: GameScreenRouterInput {
    func goToScrollView() {
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        
        let gameScreenViewController: GameScreenViewController = viewController as! GameScreenViewController
        
        let context: ScoresContext = ScoresContext()
//        let container: ScoresContainer = ScoresContainer.assemble(with: context)
         let container: ScoresContainer = ScoresContainer.assemble(with: context, gameInfo: gameScreenViewController.gameInfo!)
        let scoreScreenController: UIViewController = container.viewController
        
        navController.pushViewController(scoreScreenController, animated: true)
        
    }
    
}

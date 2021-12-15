//
//  ResultsRouter.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import UIKit

final class ResultsRouter {
    weak var viewController: UIViewController?
}

extension ResultsRouter: ResultsRouterInput {
    func goToStartView() {
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        let container = StartContainer.assemble(with: StartContext())
        navController.pushViewController(container.viewController, animated: true)
        
//        container.viewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.viewController?.present(container.viewController, animated: true, completion: nil)
        
    }
    
    func goToGameView() {
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        
        let resultsViewController: ResultsViewController = viewController as! ResultsViewController
        
        let context: GameScreenContext = GameScreenContext()
//        let container: ScoresContainer = ScoresContainer.assemble(with: context)
         let container: GameScreenContainer = GameScreenContainer.assemble(with: context, gameInfo: resultsViewController.gameInfo!)
        let gameScreenController: UIViewController = container.viewController
        
//        gameScreenController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.viewController?.present(gameScreenController, animated: true, completion: nil)
        
        navController.pushViewController(gameScreenController, animated: true)
//        self.viewController?.present(resultsScreenController, animated: true, completion: nil)
//        self.viewController?.presentedViewController(resultsScreenController, animated: true)
    }
    
}

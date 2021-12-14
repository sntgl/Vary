//
//  ScoresRouter.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import UIKit

final class ScoresRouter {
    weak var viewController: UIViewController?
}

extension ScoresRouter: ScoresRouterInput {
    func goToResultsView() {
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
        
        let scoresViewController: ScoresViewController = viewController as! ScoresViewController
        
        let context: ResultsContext = ResultsContext()
//        let container: ScoresContainer = ScoresContainer.assemble(with: context)
         let container: ResultsContainer = ResultsContainer.assemble(with: context, gameInfo: scoresViewController.gameInfo!)
        let resultsScreenController: UIViewController = container.viewController
        
        navController.pushViewController(resultsScreenController, animated: true)
    }
    
}

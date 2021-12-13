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
        let container = ScoresContainer.assemble(with: ScoresContext())
        navController.pushViewController(container.viewController, animated: true)
    }
    
}

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
        let navController: UINavigationController = viewController?.navigationController ?? CustomNavigationController(rootViewController: self.viewController!)
//        if  viewController?.navigationController else {
//            print("no nav controller")
//            let myNavController = CustomNavigationController(rootViewController: viewController!)
//            let container = TeamsContainer.assemble(with: TeamsContext())
//            myNavController.pushViewController(container.viewController, animated: true)
//            return
//        }
//        navController = CustomNavigationController()
        let container = TeamsContainer.assemble(with: TeamsContext())
        navController.pushViewController(container.viewController, animated: true)
//        viewController.rootViewController = container
    }
    
    func openSettings(){
        guard let navController = viewController?.navigationController else {
            print("no nav controller")
            return
        }
//        let container = ScoresContainer.assemble(with: ScoresContext())
//        navController.pushViewController(container.viewController, animated: true)
        
//                let container = ResultsContainer.assemble(with: ResultsContext())
//                navController.pushViewController(container.viewController, animated: true)
    }
}

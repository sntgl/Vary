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
    
    func startNewGame(settingsViewController: UIViewController) {
        guard let navController = settingsViewController.navigationController else {
            print("no nav controller")
            return
        }
        navController.popViewController(animated: true)
//        let context: StartContext = StartContext()
//        let container: StartContainer = StartContainer.assemble(with: context)
//        let startController: UIViewController = container.viewController
//        startController.modalPresentationStyle = .fullScreen
//        settingsViewController.present(startController, animated: true, completion: nil)
    }
}

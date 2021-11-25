//
//  TeamsRouter.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//
//

import UIKit

final class TeamsRouter {
    weak var viewController: UIViewController?
}

extension TeamsRouter: TeamsRouterInput {
    func backToStartViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    func nextScreen() {
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

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
}

//
//  TeamsContainer.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//  Второй экран, за него отвечает Даня

import UIKit

final class TeamsContainer {
    let input: TeamsModuleInput
	let viewController: UIViewController
	private(set) weak var router: TeamsRouterInput!

	class func assemble(with context: TeamsContext) -> TeamsContainer {
        let router = TeamsRouter()
        let interactor = TeamsInteractor()
        let presenter = TeamsPresenter(router: router, interactor: interactor)
		let viewController = TeamsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return TeamsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: TeamsModuleInput, router: TeamsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct TeamsContext {
	weak var moduleOutput: TeamsModuleOutput?
}

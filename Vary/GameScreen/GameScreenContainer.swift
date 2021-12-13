//
//  GameScreenContainer.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class GameScreenContainer {
    let input: GameScreenModuleInput
	let viewController: UIViewController
	private(set) weak var router: GameScreenRouterInput!

	class func assemble(with context: GameScreenContext) -> GameScreenContainer {
        let router = GameScreenRouter()
        let interactor = GameScreenInteractor()
        let presenter = GameScreenPresenter(router: router, interactor: interactor)
		let viewController = GameScreenViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.viewController = viewController
		interactor.output = presenter

        return GameScreenContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: GameScreenModuleInput, router: GameScreenRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct GameScreenContext {
	weak var moduleOutput: GameScreenModuleOutput?
}

//
//  ScoresContainer.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import UIKit

final class ScoresContainer {
    let input: ScoresModuleInput
	let viewController: UIViewController
	private(set) weak var router: ScoresRouterInput!

    class func assemble(with context: ScoresContext, gameInfo info: GameInfo) -> ScoresContainer {
//    class func assemble(with context: ScoresContext) -> ScoresContainer {
        let router = ScoresRouter()
        let interactor = ScoresInteractor()
        let presenter = ScoresPresenter(router: router, interactor: interactor)
		let viewController = ScoresViewController(output: presenter, gameInfo: info)
//        let viewController = ScoresViewController(output: presenter)
        
		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        router.viewController = viewController
		interactor.output = presenter

        return ScoresContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ScoresModuleInput, router: ScoresRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ScoresContext {
	weak var moduleOutput: ScoresModuleOutput?
}

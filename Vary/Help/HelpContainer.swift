//
//  HelpContainer.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class HelpContainer {
    let input: HelpModuleInput
	let viewController: UIViewController
	private(set) weak var router: HelpRouterInput!

	class func assemble(with context: HelpContext) -> HelpContainer {
        let router = HelpRouter()
        let interactor = HelpInteractor()
        let presenter = HelpPresenter(router: router, interactor: interactor)
		let viewController = HelpViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return HelpContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: HelpModuleInput, router: HelpRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct HelpContext {
	weak var moduleOutput: HelpModuleOutput?
}

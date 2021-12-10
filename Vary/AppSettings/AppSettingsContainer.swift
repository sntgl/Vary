//
//  AppSettingsContainer.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class AppSettingsContainer {
    let input: AppSettingsModuleInput
	let viewController: UIViewController
	private(set) weak var router: AppSettingsRouterInput!

	class func assemble(with context: AppSettingsContext) -> AppSettingsContainer {
        let router = AppSettingsRouter()
        let interactor = AppSettingsInteractor()
        let presenter = AppSettingsPresenter(router: router, interactor: interactor)
		let viewController = AppSettingsViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return AppSettingsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: AppSettingsModuleInput, router: AppSettingsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct AppSettingsContext {
	weak var moduleOutput: AppSettingsModuleOutput?
}

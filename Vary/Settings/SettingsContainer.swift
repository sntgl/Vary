//
//  SettingsContainer.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import UIKit

final class SettingsContainer {
    let input: SettingsModuleInput
	let viewController: UIViewController
	private(set) weak var router: SettingsRouterInput!

    class func assemble(with context: SettingsContext, teamsInfo teams: AllTeams) -> SettingsContainer {
        let router = SettingsRouter()
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(router: router, interactor: interactor)
        let viewController = SettingsViewController(output: presenter, allTeamsInfo: teams)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        //my changes
        router.viewController = viewController
		
        interactor.output = presenter

        return SettingsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: SettingsModuleInput, router: SettingsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct SettingsContext {
	weak var moduleOutput: SettingsModuleOutput?
}

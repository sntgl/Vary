//
//  AppSettingsPresenter.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import Foundation

final class AppSettingsPresenter {
	weak var view: AppSettingsViewInput?
    weak var moduleOutput: AppSettingsModuleOutput?

	private let router: AppSettingsRouterInput
	private let interactor: AppSettingsInteractorInput

    init(router: AppSettingsRouterInput, interactor: AppSettingsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AppSettingsPresenter: AppSettingsModuleInput {
}

extension AppSettingsPresenter: AppSettingsViewOutput {
}

extension AppSettingsPresenter: AppSettingsInteractorOutput {
}

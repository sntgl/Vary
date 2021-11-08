//
//  SettingsPresenter.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import Foundation

final class SettingsPresenter {
	weak var view: SettingsViewInput?
    weak var moduleOutput: SettingsModuleOutput?

	private let router: SettingsRouterInput
	private let interactor: SettingsInteractorInput

    init(router: SettingsRouterInput, interactor: SettingsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SettingsPresenter: SettingsModuleInput {
}

extension SettingsPresenter: SettingsViewOutput {
}

extension SettingsPresenter: SettingsInteractorOutput {
}

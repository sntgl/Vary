//
//  SettingsPresenter.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import Foundation
import UIKit

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
    func onSettingsButtonClicked(settingsViewController: UIViewController) {
        router.startNewGame(settingsViewController:settingsViewController)
    }
    
}

extension SettingsPresenter: SettingsInteractorOutput {
}

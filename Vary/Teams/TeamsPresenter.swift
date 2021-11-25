//
//  TeamsPresenter.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//
//

import Foundation

final class TeamsPresenter {
    weak var view: TeamsViewInput?
    weak var moduleOutput: TeamsModuleOutput?

    private let router: TeamsRouterInput
    private let interactor: TeamsInteractorInput

    init(router: TeamsRouterInput, interactor: TeamsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TeamsPresenter: TeamsModuleInput {
}

extension TeamsPresenter: TeamsViewOutput {
    func didBackToStartViewControllerButton() {
        router.backToStartViewController()
    }
    
    func didContinue() {
        router.nextScreen()
    }

}

extension TeamsPresenter: TeamsInteractorOutput {
}

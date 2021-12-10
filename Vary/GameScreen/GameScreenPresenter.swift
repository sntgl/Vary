//
//  GameScreenPresenter.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import Foundation

final class GameScreenPresenter {
	weak var view: GameScreenViewInput?
    weak var moduleOutput: GameScreenModuleOutput?

	private let router: GameScreenRouterInput
	private let interactor: GameScreenInteractorInput

    init(router: GameScreenRouterInput, interactor: GameScreenInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension GameScreenPresenter: GameScreenModuleInput {
}

extension GameScreenPresenter: GameScreenViewOutput {
}

extension GameScreenPresenter: GameScreenInteractorOutput {
}

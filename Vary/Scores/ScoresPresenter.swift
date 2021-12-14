//
//  ScoresPresenter.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import Foundation

final class ScoresPresenter {
	weak var view: ScoresViewInput?
    weak var moduleOutput: ScoresModuleOutput?

	private let router: ScoresRouterInput
	private let interactor: ScoresInteractorInput

    init(router: ScoresRouterInput, interactor: ScoresInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ScoresPresenter: ScoresModuleInput {
}

extension ScoresPresenter: ScoresViewOutput {
    func goToResultsView() {
        self.router.goToResultsView()
    }
    
}

extension ScoresPresenter: ScoresInteractorOutput {
}

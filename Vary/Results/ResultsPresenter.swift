//
//  ResultsPresenter.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import Foundation

final class ResultsPresenter {
	weak var view: ResultsViewInput?
    weak var moduleOutput: ResultsModuleOutput?

	private let router: ResultsRouterInput
	private let interactor: ResultsInteractorInput

    init(router: ResultsRouterInput, interactor: ResultsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ResultsPresenter: ResultsModuleInput {
}

extension ResultsPresenter: ResultsViewOutput {
    func goToStartView() {
        router.goToStartView()
    }
    
    func goToGameView() {
        router.goToGameView()
    }
    
}

extension ResultsPresenter: ResultsInteractorOutput {
}

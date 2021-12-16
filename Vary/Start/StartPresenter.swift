//
//  StartPresenter.swift
//  Vary
//
//  Created by Александр Тагилов on 07.11.2021.
//  
//

import Foundation

final class StartPresenter {
	weak var view: StartViewInput?
    weak var moduleOutput: StartModuleOutput?

	private let router: StartRouterInput
	private let interactor: StartInteractorInput

    init(router: StartRouterInput, interactor: StartInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension StartPresenter: StartModuleInput {
}

extension StartPresenter: StartViewOutput {
    func openHelp() {
        router.openHelp()
    }
    
    func viewDidLoad() {
        interactor.loadCards()
        
    }
    
    func onSettingsButtonClicked() {
        router.openSettings()
    }
    
    func didTapStartNewGameButton() {
        router.startNewGame()
    }
    
}

extension StartPresenter: StartInteractorOutput {
    func loadedCards(_ version: Int) {
        view?.showInfoMessage(message:String(version))
    }
    
}

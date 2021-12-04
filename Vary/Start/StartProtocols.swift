//
//  StartProtocols.swift
//  Vary
//
//  Created by Александр Тагилов on 07.11.2021.
//  
//

import Foundation

protocol StartModuleInput {
	var moduleOutput: StartModuleOutput? { get }
}

protocol StartModuleOutput: AnyObject {
}

protocol StartViewInput: AnyObject {
    func showInfoMessage(message:String)
    
}

protocol StartViewOutput: AnyObject {
    func didTapStartNewGameButton()
    
    func onSettingsButtonClicked()
    
    func viewDidLoad()
}

protocol StartInteractorInput: AnyObject {
    func loadVersion()
    
    func loadCards()
    
}

protocol StartInteractorOutput: AnyObject {
    
    func loadedCards(_ version:Int)
}

protocol StartRouterInput: AnyObject {
    func startNewGame()
    func openSettings()
}

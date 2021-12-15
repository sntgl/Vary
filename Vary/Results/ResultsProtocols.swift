//
//  ResultsProtocols.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import Foundation

protocol ResultsModuleInput {
	var moduleOutput: ResultsModuleOutput? { get }
}

protocol ResultsModuleOutput: AnyObject {
}

protocol ResultsViewInput: AnyObject {
}

protocol ResultsViewOutput: AnyObject {
    
    func goToStartView()
    func goToGameView()
}

protocol ResultsInteractorInput: AnyObject {
}

protocol ResultsInteractorOutput: AnyObject {
}

protocol ResultsRouterInput: AnyObject {
    func goToStartView()
    func goToGameView()
}

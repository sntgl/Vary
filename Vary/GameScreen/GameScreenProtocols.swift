//
//  GameScreenProtocols.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import Foundation

protocol GameScreenModuleInput {
	var moduleOutput: GameScreenModuleOutput? { get }
}

protocol GameScreenModuleOutput: AnyObject {
}

protocol GameScreenViewInput: AnyObject {
}

protocol GameScreenViewOutput: AnyObject {
    func goToScrollView()
}

protocol GameScreenInteractorInput: AnyObject {
}

protocol GameScreenInteractorOutput: AnyObject {
}

protocol GameScreenRouterInput: AnyObject {
    func goToScrollView()
}

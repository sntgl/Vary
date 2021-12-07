//
//  ScoresProtocols.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import Foundation

protocol ScoresModuleInput {
	var moduleOutput: ScoresModuleOutput? { get }
}

protocol ScoresModuleOutput: AnyObject {
}

protocol ScoresViewInput: AnyObject {
}

protocol ScoresViewOutput: AnyObject {
}

protocol ScoresInteractorInput: AnyObject {
}

protocol ScoresInteractorOutput: AnyObject {
}

protocol ScoresRouterInput: AnyObject {
}

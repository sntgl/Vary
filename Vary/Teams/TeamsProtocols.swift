//
//  TeamsProtocols.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import Foundation

protocol TeamsModuleInput {
	var moduleOutput: TeamsModuleOutput? { get }
}

protocol TeamsModuleOutput: class {
}

protocol TeamsViewInput: class {
}

protocol TeamsViewOutput: class {
}

protocol TeamsInteractorInput: class {
}

protocol TeamsInteractorOutput: class {
}

protocol TeamsRouterInput: class {
}

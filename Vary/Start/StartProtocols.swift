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
}

protocol StartViewOutput: AnyObject {
}

protocol StartInteractorInput: AnyObject {
}

protocol StartInteractorOutput: AnyObject {
}

protocol StartRouterInput: AnyObject {
}

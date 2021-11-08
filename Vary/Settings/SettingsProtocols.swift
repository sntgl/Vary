//
//  SettingsProtocols.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import Foundation

protocol SettingsModuleInput {
	var moduleOutput: SettingsModuleOutput? { get }
}

protocol SettingsModuleOutput: AnyObject {
}

protocol SettingsViewInput: AnyObject {
}

protocol SettingsViewOutput: AnyObject {
}

protocol SettingsInteractorInput: AnyObject {
}

protocol SettingsInteractorOutput: AnyObject {
}

protocol SettingsRouterInput: AnyObject {
}

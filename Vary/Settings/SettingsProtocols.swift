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

protocol SettingsModuleOutput: class {
}

protocol SettingsViewInput: class {
}

protocol SettingsViewOutput: class {
}

protocol SettingsInteractorInput: class {
}

protocol SettingsInteractorOutput: class {
}

protocol SettingsRouterInput: class {
}

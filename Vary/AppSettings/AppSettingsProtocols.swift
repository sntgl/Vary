//
//  AppSettingsProtocols.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import Foundation

protocol AppSettingsModuleInput {
	var moduleOutput: AppSettingsModuleOutput? { get }
}

protocol AppSettingsModuleOutput: AnyObject {
}

protocol AppSettingsViewInput: AnyObject {
}

protocol AppSettingsViewOutput: AnyObject {
}

protocol AppSettingsInteractorInput: AnyObject {
}

protocol AppSettingsInteractorOutput: AnyObject {
}

protocol AppSettingsRouterInput: AnyObject {
}

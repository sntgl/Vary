//
//  HelpProtocols.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import Foundation

protocol HelpModuleInput {
	var moduleOutput: HelpModuleOutput? { get }
}

protocol HelpModuleOutput: AnyObject {
}

protocol HelpViewInput: AnyObject {
}

protocol HelpViewOutput: AnyObject {
}

protocol HelpInteractorInput: AnyObject {
}

protocol HelpInteractorOutput: AnyObject {
}

protocol HelpRouterInput: AnyObject {
}

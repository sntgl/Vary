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

protocol TeamsModuleOutput: AnyObject {
}

protocol TeamsViewInput: AnyObject {
}

protocol TeamsViewOutput: AnyObject {
    func didBackToStartViewControllerButton()
}

protocol TeamsInteractorInput: AnyObject {
}

protocol TeamsInteractorOutput: AnyObject {
}

protocol TeamsRouterInput: AnyObject {
    func backToStartViewController()
}


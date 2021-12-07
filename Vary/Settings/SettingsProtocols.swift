//
//  SettingsProtocols.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import Foundation
import UIKit

protocol SettingsModuleInput {
	var moduleOutput: SettingsModuleOutput? { get }
}

protocol SettingsModuleOutput: AnyObject {
}

protocol SettingsViewInput: AnyObject {
}

protocol SettingsViewOutput: AnyObject {
    func onSettingsButtonClicked(settingsViewController: UIViewController)
    func onNextButtonClicked()
}

protocol SettingsInteractorInput: AnyObject {
}

protocol SettingsInteractorOutput: AnyObject {
}

protocol SettingsRouterInput: AnyObject {
    func startNewGame(settingsViewController: UIViewController)
    func nextScreen()
}

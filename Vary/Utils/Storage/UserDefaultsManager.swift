//
//  UserDefaultsManager.swift
//  Vary
//
//  Created by user207433 on 11/28/21.
//

import Foundation

protocol UserDefaultsManagerProtocol: AnyObject {
    var appVersion: Int { get set }
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    private let userDefaults = UserDefaults()
    private let appVersionKey = "appVersionKey"
    
    var appVersion: Int {
        get {
            return userDefaults.integer(forKey: appVersionKey)
        }
        set {
            userDefaults.set(newValue, forKey: appVersionKey)
        }
    }
    
    
}

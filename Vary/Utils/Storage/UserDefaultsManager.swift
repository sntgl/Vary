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
    let userDefaults = UserDefaults()
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

extension UserDefaults {

    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func set<T: Codable>(object: T, forKey: String) throws {
        
        if let jsonData = try? JSONEncoder().encode(object) {
            let defaults = UserDefaults.standard
            defaults.set(jsonData, forKey: forKey)
        }

    }

    /// Get Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {

        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }

        return try JSONDecoder().decode(objectType, from: result)
    }
}

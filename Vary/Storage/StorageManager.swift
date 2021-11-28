//
//  StorageManager.swift
//  Vary
//
//  Created by user207433 on 11/28/21.
//

import Foundation

protocol StorageManagerProtocol {
    var appVersion: Int { get }
    func saveCards()
    func loadCards()
    func saveVersion(version: Int)
}

class StorageManager {
    private let userDefaultManager: UserDefaultsManagerProtocol
    private let storageQueue = DispatchQueue(label: "StorageQueue")
    
    var appVersion: Int {
        storageQueue.sync { userDefaultManager.appVersion }
    }
    
    init(userDefaultManager: UserDefaultsManagerProtocol) {
        self.userDefaultManager = userDefaultManager
    }
    
    func saveVersion(version: Int) {
        storageQueue.async { [weak self] in
            self?.userDefaultManager.appVersion = version
        }
    }
}


class Services {
    var networkSErvice:
    var storage:
    var userDefault
    
    let shared = Services()
    
    init() {
        
    }
}

//
//  StartInteractor.swift
//  Vary
//
//  Created by Александр Тагилов on 07.11.2021.
//  
//

import Foundation

final class StartInteractor {
	weak var output: StartInteractorOutput?
    
    var appVersion: Int?
    var storageManager: StorageManagerProtocol?
    let serverIp = VaryVars.ServerRequests.serverIp

}

extension StartInteractor: StartInteractorInput {
    
    func loadVersion(){
        let userDefault = UserDefaultsManager() // want tot delete
        self.storageManager = StorageManager(userDefaultManager: userDefault)
        self.appVersion = storageManager!.appVersion //wtf
        
    }
    
    func loadCards() {
        self.loadVersion()
        let networkManager: NetworkManager = VaryNetwork(appVersion: self.appVersion ?? 0, serverIp: self.serverIp)
        var serverVersion: Int = 0
        networkManager.getLastVersion { result in
          
            switch result{
            case .success(let version):
                // KAKOITO PIZDEC
//                if serverVersion > self.appVersion ?? 0 {
//                    sel
//
               
                serverVersion = version
                self.downloadingCards(networkManager, serverVersion)
                    
            case .failure(let error):
                print("Error in Interactor  \(error)") // TODO ErrorBox
                }
            
        }
    
        
        
    }
    
    func downloadingCards(_ networkManager:NetworkManager, _ serverVersion: Int){
        
            if serverVersion > appVersion ?? 0 {
                networkManager.getCards { [weak output] result in
                    DispatchQueue.main.async {
                    switch result{
                        case .success(let downloadedCards):
                            self.storageManager?.saveCards(downloadedCards)
                            self.storageManager?.saveVersion(version: serverVersion)
                            output?.loadedCards(serverVersion)
                            
                        case .failure(let error):
                            print("Error in Interactor 2: \(error)") // TODO ErrorBox
                        
                        }
                    }
                    
                }
            }

    }
    
    
}

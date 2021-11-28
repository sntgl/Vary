//
//  Network.swift
//  Vary
//
//  Created by user207433 on 11/28/21.
//

import Foundation

protocol NetworkManager{
    
    func getLastVersion() -> Int?
    
    func getNewCards() -> Dictionary?
    
    // ==========================
    
    func getLastVersionAsync(completion: @escaping (Result<Int, Error>) -> Void)
    
}


class VaryNetwork: NetworkManager{
    
    
    
    private let version:Int
    private var ip:String {
        didSet{
            requestGetVersion = "http://\(ip)/categories/version"
            requestGetCards = "http://\(ip)/categories?version=\(version)"
        }
    }

    private var requestGetVersion:String = ""
    private var requestGetCards:String = ""
    
    init(appVersion version:Int, serverIp ip:String) {
        self.version = version
        self.ip = ip
    }
    
    func getLastVersion() -> Int? {
            
        guard let url = URL(string: requestGetVersion) else { return nil }
        
        let session = URLSession.shared
        var serverVersion: Int? = -1
        session.dataTask(with: url) { (data, response, error) in
             
            
            guard let response = response, let data = data else { return }
            
            print(response)
            print(data)
            
//            do {
                serverVersion = Int(String(decoding: data, as: UTF8.self))
            

//            } catch {
//                print(error)
//            }
        }.resume()
        return nil
    }
    
    func getNewCards() -> Dictionary? {
        
        guard let url = URL(string: requestGetCards) else { return nil}
        
        let session = URLSession.shared
        var downloadedDictionary: Dictionary
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response, let data = data else { return }
            
            print(response)
            print(data)
            
            do {
                downloadedDictionary = try JSONDecoder().decode(Dictionary.self, from: data)
                print(downloadedDictionary.name)
            } catch {
                print(error)
            }
        }.resume()
        
        return downloadedDictionary
    }
    
    func getLastVersionAsync(completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: requestGetVersion) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response, let data = data else {
                completion(.failure(NSError(domain: "test_error", code: 1, userInfo: nil)))
                print("getLastVersionAsync - error")
                return
            }
            
            if let error = error {
                completion(.failure(NSError(domain: "test_error", code: 1, userInfo: nil)))
                print("error occurred: \(error)")
                
                return
            }
            
            print(response)
            print(data)
            guard let serverVersion = Int(String(decoding: data, as: UTF8.self)) else {
                completion(.failure(NSError(domain: "test_error", code: 1, userInfo: nil)))
                return
            }
            completion(.success(serverVersion))
        
        }.resume()
    }
}


enum CustomError: Error, CustomDebugStringConvertible {
    case missingData
    case kek
    
    var debugDescription: String {
        switch self {
        case .missingData: return "ajkshd"
        case .kek: return "asdasda"
        }
    }
}

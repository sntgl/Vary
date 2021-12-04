//
//  Network.swift
//  Vary
//
//  Created by user207433 on 11/28/21.
//

import Foundation

protocol NetworkManager{
    
    
    func getLastVersion(completion: @escaping (Result<Int, Error>) -> Void)
    
    func getCards(completion: @escaping (Result<Dictionary, Error>) -> Void)
    
}



enum NetworkError: Error {
    case invalidIpRequest
    case missingData
    case connectionError
    case decodingError
    
//    var debugDescription: String {
//        switch self {
//        case .missingData: return "ajkshd"
//        case .kek: return "asdasda"
//        }
//    }
}



class VaryNetwork: NetworkManager{

    
    
    
    private let version:Int
    private let ip:String
    
    
    private var requestGetVersionIp: String {
        return "\(ip)/categories/version"
    }
  
    private var requestGetCards:String {
        return "\(ip)/categories?version=\(version)"
    }
    
    init(appVersion version:Int, serverIp ip:String) {
        self.version = version
        self.ip = ip
    }
    
//    func getLastVersion() -> Int? {
//
//        guard let url = URL(string: requestGetVersion) else { return nil }
//
//        let session = URLSession.shared
//        var serverVersion: Int? = -1
//        session.dataTask(with: url) { (data, response, error) in
//
//
//            guard let response = response, let data = data else { return }
//
//            print(response)
//            print(data)
//
////            do {
//                serverVersion = Int(String(decoding: data, as: UTF8.self))
//
//
////            } catch {
////                print(error)
////            }
//        }.resume()
//        return nil
//    }
    
    func getLastVersion(completion: @escaping (Result<Int, Error>) -> Void) {
        guard let url = URL(string: requestGetVersion) else {
            completion(.failure(NetworkError.invalidIpRequest))
            return
            
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            // TODO think about of error/response chekcking order
            guard let response = response, let data = data else {
                completion(.failure(NetworkError.missingData))
                print("getLastVersionAsync - error")
                return
            }
            
            if let error = error {
                completion(.failure(NetworkError.connectionError))
                print("error occurred: \(error)")
                return
            }
            
            print(response)
            print(data)
            guard let serverVersion = Int(String(decoding: data, as: UTF8.self)) else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            completion(.success(serverVersion))
        
        }.resume()
    }
    
    
    
    func getCards(completion: @escaping (Result<Dictionary, Error>) -> Void) {
        
        guard let url = URL(string: requestGetCards) else {
            completion(.failure(NetworkError.invalidIpRequest))
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response, let data = data else {
                completion(.failure(NetworkError.missingData))
                print("getNewCards - error")
                return
                
            }
            
            if let error = error {
                completion(.failure(NetworkError.connectionError))
                print("error occurred: \(error)")
                return
            }
            print(response)
            print(data)
            
            do {
                let downloadedDictionary: Dictionary = try JSONDecoder().decode(Dictionary.self, from: data)
                print(downloadedDictionary.name)
                completion(.success(downloadedDictionary))
            } catch {
                completion(.failure(NetworkError.decodingError))
                print(error)
            }
        }.resume()
        
    }
}


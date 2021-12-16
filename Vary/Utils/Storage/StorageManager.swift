//
//  StorageManager.swift
//  Vary
//
//  Created by user207433 on 11/28/21.
//

import Foundation

protocol StorageManagerProtocol {
    var appVersion: Int { get }
    func saveVersion(version: Int)
    func saveCards(_ cards:Dictionary)
    func loadCards() -> Dictionary?
    func isCardsSaved() -> Bool

}

class StorageManager{

    
    let userDefaultManager: UserDefaultsManagerProtocol
    private let storageQueue = DispatchQueue(label: "StorageQueue")
    private let defaultFileName = "dictionary.json"
    
    var appVersion: Int {
        storageQueue.sync { userDefaultManager.appVersion }
    }
    
    
    enum Directory {
        // Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in the <Application_Home>/Documents directory and will be automatically backed up by iCloud.
        case documents
        
        // Data that can be downloaded again or regenerated should be stored in the <Application_Home>/Library/Caches directory. Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.
        case caches
    }
    
    
    /// Returns URL constructed from specified directory
      fileprivate func getURL(for directory: Directory) -> URL {
          var searchPathDirectory: FileManager.SearchPathDirectory
          
          switch directory {
          case .documents:
              searchPathDirectory = .documentDirectory
          case .caches:
              searchPathDirectory = .cachesDirectory
          }
          
          if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
              return url
          } else {
              fatalError("Could not create URL for specified directory!")
          }
      }
    
    // Store an encodable struct to the specified directory on disk
        ///
        /// - Parameters:
        ///   - object: the encodable struct to store
        ///   - directory: where to store the struct
        ///   - fileName: what to name the file where the struct data will be stored
        func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
            let url = self.getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
            
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(object)
                if FileManager.default.fileExists(atPath: url.path) {
                    try FileManager.default.removeItem(at: url)
                }
                FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    
    /// Retrieve and convert a struct from a file on disk
        ///
        /// - Parameters:
        ///   - fileName: name of the file where struct data is stored
        ///   - directory: directory where struct data is stored
        ///   - type: struct type (i.e. Message.self)
        /// - Returns: decoded struct model(s) of data
        func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T {
            let url = self.getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
            
            if !FileManager.default.fileExists(atPath: url.path) {
                fatalError("File at path \(url.path) does not exist!")
            }
            
            if let data = FileManager.default.contents(atPath: url.path) {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(type, from: data)
                    return model
                } catch {
                    fatalError(error.localizedDescription)
                }
            } else {
                fatalError("No data at \(url.path)!")
            }
        }
    
    
    /// Remove all files at specified directory
      func clear(_ directory: Directory) {
          let url = self.getURL(for: directory)
          do {
              let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
              for fileUrl in contents {
                  try FileManager.default.removeItem(at: fileUrl)
              }
          } catch {
              fatalError(error.localizedDescription)
          }
      }
    
    /// Remove specified file from specified directory
    func remove(_ fileName: String, from directory: Directory) {
        let url = self.getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    private func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = self.getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }

    init(userDefaultManager: UserDefaultsManagerProtocol) {
       self.userDefaultManager = userDefaultManager
   }
  
    
}

extension StorageManager: StorageManagerProtocol{

    
    func saveVersion(version: Int) {
        storageQueue.async { [weak self] in
            self?.userDefaultManager.appVersion = version
        }
    }
    
    
    
    func saveCards(_ cards:Dictionary) {
        if self.fileExists(self.defaultFileName, in: .caches){
            self.remove(self.defaultFileName, from: .caches)
        }
        
        self.store(cards, to: .caches, as: self.defaultFileName)
        
    }
    
    func loadCards() -> Dictionary? {
        if self.fileExists(self.defaultFileName, in: .caches){
            return self.retrieve(self.defaultFileName, from: .caches, as: Dictionary.self)
        }
        return nil
    }
    
    
    func loadCards(numberOfCards num:Int) -> Dictionary? {
        if self.fileExists(self.defaultFileName, in: .caches){
            var loadedDict = self.retrieve(self.defaultFileName, from: .caches, as: Dictionary.self)
            var shuffled_cards: [Card] = loadedDict.cards
            shuffled_cards.shuffle()
            shuffled_cards = Array(shuffled_cards[..<num])
            loadedDict.cards = shuffled_cards
            return loadedDict
        }
        return nil
    }
    
    func isCardsSaved() -> Bool {
        if self.fileExists(self.defaultFileName, in: .caches){
            return true
        }
        return false
    }
    
}

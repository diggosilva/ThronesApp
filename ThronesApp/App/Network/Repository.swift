//
//  Repository.swift
//  ThronesApp
//
//  Created by Diggo Silva on 23/11/25.
//

import Foundation

protocol RepositoryProtocol {
    func getChars() -> [Char]
    func saveChar(_ char: Char, completion: @escaping(Result<String, DSError>) -> Void)
    func saveChars(_ chars: [Char])
}

class Repository: RepositoryProtocol {
    
    let userDefaults = UserDefaults.standard
    let keyChar = "keyChar"
    
    func getChars() -> [Char] {
        if let data = userDefaults.data(forKey: keyChar) {
            if let decoded = try? JSONDecoder().decode([Char].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    func saveChar(_ char: Char, completion: @escaping(Result<String, DSError>) -> Void) {
        var savedChars = getChars()
      
        if savedChars.contains(where: { $0.id == char.id }) {
            completion(.failure(.charAlreadyExists))
            return
        }
        savedChars.append(char)
    }
    
    func saveChars(_ chars: [Char]) {
        if let encoded = try? JSONEncoder().encode(chars) {
            userDefaults.set(encoded, forKey: keyChar)
        }
    }
}

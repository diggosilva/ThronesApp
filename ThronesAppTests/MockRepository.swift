//
//  MockRepository.swift
//  ThronesAppTests
//
//  Created by Diggo Silva on 01/12/25.
//

import Foundation
@testable import ThronesApp

final class RepositoryMock: RepositoryProtocol {

    var savedChars: [Char] = []
    var shouldThrowOnSave = false
    var saveCharCalled = false

    func getChars() -> [Char] {
        return savedChars
    }

    func saveChar(_ char: Char) async throws {
        saveCharCalled = true
        
        if shouldThrowOnSave {
            throw DSError.charAlreadyExists
        }
        
        savedChars.append(char)
    }

    func saveChars(_ chars: [Char]) {
        savedChars = chars
    }
}

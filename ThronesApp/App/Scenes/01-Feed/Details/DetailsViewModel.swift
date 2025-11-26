//
//  DetailsViewModel.swift
//  ThronesApp
//
//  Created by Diggo Silva on 25/10/25.
//

import Foundation

protocol DetailsViewModelProtocol {
    func getCharacter() -> Char
    func addToFavorites(char: Char) async throws
}

final class DetailsViewModel: DetailsViewModelProtocol {
    
    private let char: Char
    private let repository: RepositoryProtocol
    
    init(char: Char, repository: RepositoryProtocol = Repository()) {
        self.char = char
        self.repository = repository
    }
    
    func getCharacter() -> Char {
        return char
    }
    
    func addToFavorites(char: Char) async throws {
        try await repository.saveChar(char)
    }
}

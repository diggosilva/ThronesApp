//
//  DetailsViewModel.swift
//  ThronesApp
//
//  Created by Diggo Silva on 25/10/25.
//

import Foundation

protocol DetailsViewModelProtocol {
    func getCharacter() -> Char
    func addToFavorites(char: Char, completion: @escaping(Result<String, DSError>) -> Void)
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
    
    func addToFavorites(char: Char, completion: @escaping(Result<String, DSError>) -> Void) {
        repository.saveChar(char) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(.success("Saved"))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

//
//  FavoriteViewModel.swift
//  ThronesApp
//
//  Created by Diggo Silva on 23/11/25.
//

import Foundation

protocol FavoritesViewModelProtocol {
    func getChars() -> [Char]
    func numberOfRows() -> Int
    func cellForRow(at index: Int) -> Char
    func loadChars()
    func saveChars()
    func removeChar(at index: Int)
    func setDelegate(_ delegate: FavoriteViewModelDelegate)
}

protocol FavoriteViewModelDelegate: AnyObject {
    func reloadTable()
}

class FavoriteViewModel: FavoritesViewModelProtocol {
    
    private var chars: [Char] = []
    private var repository: RepositoryProtocol
    
    weak var delegate: FavoriteViewModelDelegate?
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    func getChars() -> [Char] {
        return chars
    }
    
    func numberOfRows() -> Int {
        return chars.count
    }
    
    func cellForRow(at index: Int) -> Char {
        return chars[index]
    }
    
    func loadChars() {
        chars = repository.getChars()
        delegate?.reloadTable()
    }
    
    func saveChars() {
        repository.saveChars(chars)
    }
    
    func removeChar(at index: Int) {
        chars.remove(at: index)
    }
    
    func setDelegate(_ delegate: FavoriteViewModelDelegate) {
        self.delegate = delegate
    }
}

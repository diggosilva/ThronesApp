//
//  FeedViewModel.swift
//  ThronesApp
//
//  Created by Diggo Silva on 16/10/25.
//

import Foundation
import Combine

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

protocol FeedViewModelProtocol: StatefulViewModel where State == FeedViewControllerStates {
    func numberOfRows() -> Int
    func character(at indexPath: Int) -> Char
    func searchBarTextDidChange(searchText: String)
    func fetchCharacters()
}

final class FeedViewModel: FeedViewModelProtocol {
    
    private var chars: [Char] = []
    private var filteredChars: [Char] = []
    private var searchText: String = ""
    
    var isFiltering: Bool {
        !searchText.isEmpty
    }
    
    @Published private var state: FeedViewControllerStates = .loading
    
    var statePublisher: AnyPublisher<FeedViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func numberOfRows() -> Int {
        return filteredChars.count
    }
    
    func character(at indexPath: Int) -> Char {
        return filteredChars[indexPath]
    }
    
    func searchBarTextDidChange(searchText: String) {
        self.searchText = searchText
        
        if searchText.isEmpty {
            filteredChars = chars
        } else {
            filteredChars = chars.filter { $0.fullName.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func fetchCharacters() {
        state = .loading
        
        Task { @MainActor in
            do {
                let char = try await service.getCharacters()
                chars = char
                filteredChars = chars
                state = .loaded
            } catch {
                state = .error
            }
        }
    }
}

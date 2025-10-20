//
//  FeedViewModel.swift
//  ThronesApp
//
//  Created by Diggo Silva on 16/10/25.
//

import Foundation.NSIndexPath
import Combine

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

protocol FeedViewModelProtocol: StatefulViewModel where State == FeedViewControllerStates {
    func numberOfRows() -> Int
    func character(at indexPath: Int) -> Char
    func fetchCharacters()
}

final class FeedViewModel: FeedViewModelProtocol {
    
    private var listChars: [Char] = []
    
    @Published private var state: FeedViewControllerStates = .loading
    
    var statePublisher: AnyPublisher<FeedViewControllerStates, Never> {
        $state.eraseToAnyPublisher()
    }
    
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func numberOfRows() -> Int {
        return listChars.count
    }
    
    func character(at indexPath: Int) -> Char {
        return listChars[indexPath]
    }
    
    func fetchCharacters() {
        state = .loading
        
        Task { @MainActor in
            do {
                let char = try await service.getCharacters()
                listChars.append(contentsOf: char)
                state = .loaded
            } catch {
                state = .error
                throw error
            }
        }
    }
}

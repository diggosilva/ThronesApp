//
//  DetailsViewModel.swift
//  ThronesApp
//
//  Created by Diggo Silva on 25/10/25.
//

import Foundation

protocol DetailsViewModelProtocol {
    func getCharacter() -> Char
}

final class DetailsViewModel: DetailsViewModelProtocol {
    
    private let char: Char
    
    init(char: Char) {
        self.char = char
    }
    
    func getCharacter() -> Char {
        return char
    }
}

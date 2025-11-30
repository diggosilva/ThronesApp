//
//  DSError.swift
//  ThronesApp
//
//  Created by Diggo Silva on 23/11/25.
//

import Foundation

enum DSError: String, Error {
    case charAlreadyExists = "Você já possui esses personagem nos seus favoritos."
    case unknown = "Ocorreu um erro inesperado."
}

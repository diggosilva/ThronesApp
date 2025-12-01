//
//  Char.swift
//  ThronesApp
//
//  Created by Diggo Silva on 15/10/25.
//

import Foundation

struct Char: Codable, Equatable {
    let id: Int
    let firstName, lastName, fullName, title: String
    let family, image: String
    let imageUrl: String
}

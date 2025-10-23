//
//  CharResponse.swift
//  ThronesApp
//
//  Created by Diggo Silva on 15/10/25.
//

import Foundation

struct CharResponse: Codable, Hashable {
    let id: Int
    let firstName, lastName, fullName, title: String
    let family, image: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, fullName, title, family, image
        case imageURL = "imageUrl"
    }
}

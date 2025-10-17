//
//  Service.swift
//  ThronesApp
//
//  Created by Diggo Silva on 15/10/25.
//

import Foundation

protocol ServiceProtocol {
    func getCharacters() async throws -> [Char]
}

final class Service: ServiceProtocol {
    
    func getCharacters() async throws -> [Char] {
        guard let url = URL(string: "https://thronesapi.com/api/v2/Characters") else {
            throw URLError(.badServerResponse)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let charResponse = try JSONDecoder().decode([CharResponse].self, from: data)
        var charList: [Char] = []
        
        for char in charResponse {
            let char = Char(
                id: char.id,
                firstName: char.firstName,
                lastName: char.lastName,
                fullName: char.fullName,
                title: char.title,
                family: char.family,
                image: char.image,
                imageUrl: char.imageURL
            )
            charList.append(char)
        }
        return charList
    }
}

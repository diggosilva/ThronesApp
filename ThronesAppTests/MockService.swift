//
//  MockService.swift
//  ThronesAppTests
//
//  Created by Diggo Silva on 30/11/25.
//

import XCTest
@testable import ThronesApp

class MockService: ServiceProtocol {
    
    var isSuccess: Bool = true
    var isFiltering: Bool = false
    
    func getCharacters() async throws -> [Char] {
        if isSuccess {
            return [
                Char(id: 1, firstName: "Mario", lastName: "Bros", fullName: "Mario Bros", title: "", family: "", image: "", imageUrl: ""),
                Char(id: 1, firstName: "Luigi", lastName: "Bros", fullName: "Luigi Bros", title: "", family: "", image: "", imageUrl: ""),
            ]
        } else {
            throw DSError.unknown
        }
    }
}

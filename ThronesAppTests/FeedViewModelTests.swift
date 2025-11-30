//
//  FeedViewModelTests.swift
//  ThronesAppTests
//
//  Created by Diggo Silva on 30/11/25.
//

import XCTest
import Combine
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

final class FeedViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    @MainActor
    func testWhenGettingCharsSuccessfully() async throws {
        let mockService = MockService()
        let sut = FeedViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .loaded")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        sut.fetchCharacters()
        
        // Aguarda o estado ser emitido
        await fulfillment(of: [expectation], timeout: 1)

        // Aguarda o RunLoop processar o Combine E o Task da ViewModel
        RunLoop.main.run(until: Date().addingTimeInterval(0.05))

        // Agora os arrays estão atualizados
        XCTAssertEqual(sut.numberOfRows(), 2)

        let secondChar = sut.character(at: 1)
        XCTAssertEqual(secondChar.firstName, "Luigi")
    }
    
    @MainActor
    func testWhenIsFiltering() async throws {
        let mockService = MockService()
        mockService.isSuccess = true
        let sut = FeedViewModel(service: mockService)

        let expectation = expectation(description: "Loaded")

        sut.statePublisher
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.fetchCharacters()

        // Espera realmente carregar
        await fulfillment(of: [expectation], timeout: 1)

        // Aplica filtro
        sut.searchBarTextDidChange(searchText: "Lui")

        // Aqui você usa 3 para confirmar que retorna 1
        XCTAssertEqual(sut.numberOfRows(), 1)
    }
    
    @MainActor
    func testIsFilteringFlag() async throws {
        let mockService = MockService()
        let sut = FeedViewModel(service: mockService)
        
        XCTAssertFalse(sut.isFiltering)
        print("Está filtrando? \(sut.isFiltering)")
        
        sut.searchBarTextDidChange(searchText: "Lu")
        
        XCTAssertTrue(sut.isFiltering)
        print("Está filtrando? \(sut.isFiltering)")
    }
    
    @MainActor
    func testWhenGettingCharsFails() async throws {
        let mockService = MockService()
        mockService.isSuccess = false
        let sut = FeedViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "State deveria ser .failed")
        
        sut.statePublisher
            .receive(on: RunLoop.main)
            .sink { state in
                if state == .error {
                    expectation.fulfill()
                }
            }.store(in: &cancellables)
        
        sut.fetchCharacters()
        
        await fulfillment(of: [expectation], timeout: 1)
        
        XCTAssertEqual(sut.numberOfRows(), 0)
    }
}

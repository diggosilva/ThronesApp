//
//  DetailsViewModelTests.swift
//  ThronesAppTests
//
//  Created by Diggo Silva on 01/12/25.
//

import XCTest
@testable import ThronesApp

final class DetailsViewModelTests: XCTestCase {
    
    private var mockChar: Char!
    private var repositoryMock: RepositoryMock!
    private var sut: DetailsViewModel!
    
    override func setUp() {
        super.setUp()
        mockChar = makeMockChar()
        repositoryMock = RepositoryMock()
        sut = DetailsViewModel(char: mockChar, repository: repositoryMock)
    }
    
    override func tearDown() {
        mockChar = nil
        repositoryMock = nil
        sut = nil
        super.tearDown()
    }
    
    private func makeMockChar() -> Char {
        return Char(id: 1, firstName: "Jon", lastName: "Snow", fullName: "Jon Snow", title: "", family: "", image: "", imageUrl: "")
    }
    
    // MARK: - Test getCharacter
    func test_getCharacter_returnsGivenChar() {
        let returnedChar = sut.getCharacter()
        
        XCTAssertEqual(returnedChar.firstName, mockChar.firstName)
    }
    
    // MARK: - Test addToFavorites success
    @MainActor
    func test_addToFavorites_callsRepositorySave() async throws {
        try await sut.addToFavorites(char: mockChar)
        
        XCTAssertTrue(repositoryMock.saveCharCalled, "saveChar deveria ser chamado")
        XCTAssertEqual(repositoryMock.savedChars.count, 1, "Personagem deveria ter sido salvo")
        XCTAssertEqual(repositoryMock.savedChars.first, mockChar)
    }
    
    // MARK: - Test addToFavorites throws error
    @MainActor
    func test_addToFavorites_throwsError_whenRepositoryFails() async {
        repositoryMock.shouldThrowOnSave = true
        
        let sut = DetailsViewModel(char: mockChar, repository: repositoryMock)
        
        do {
            try await sut.addToFavorites(char: mockChar)
            XCTFail("Era esperado lançar erro, mas o método não lançou")
        } catch {
            XCTAssertEqual(error as? DSError, DSError.charAlreadyExists)
        }
    }
}

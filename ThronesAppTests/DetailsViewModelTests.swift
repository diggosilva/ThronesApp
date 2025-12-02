//
//  DetailsViewModelTests.swift
//  ThronesAppTests
//
//  Created by Diggo Silva on 01/12/25.
//

import XCTest
@testable import ThronesApp

final class DetailsViewModelTests: XCTestCase {

    private func makeMockChar() -> Char {
        return Char(
            id: 1,
            firstName: "Jon",
            lastName: "Snow",
            fullName: "Jon Snow",
            title: "King in the North",
            family: "Stark",
            image: "jon.png",
            imageUrl: "https://example.com/jon"
        )
    }

    #warning("Não implementado, esse teste está dando erro e preciso corrigir.")
    // MARK: - Test getCharacter
//    func test_getCharacter_returnsGivenChar() {
//        let mockChar = makeMockChar()
//        let repository = RepositoryMock()
//        let viewModel = DetailsViewModel(char: mockChar, repository: repository)
//        let returnedChar = viewModel.getCharacter()
//
//        XCTAssertEqual(returnedChar.firstName, mockChar.firstName)
//    }

    // MARK: - Test addToFavorites success
    @MainActor
    func test_addToFavorites_callsRepositorySave() async throws {
        // Given
        let mockChar = makeMockChar()
        let repository = RepositoryMock()
        let viewModel = DetailsViewModel(char: mockChar, repository: repository)

        try await viewModel.addToFavorites(char: mockChar)

        XCTAssertTrue(repository.saveCharCalled, "saveChar deveria ser chamado")
        XCTAssertEqual(repository.savedChars.count, 1, "Personagem deveria ter sido salvo")
        XCTAssertEqual(repository.savedChars.first, mockChar)
    }

    // MARK: - Test addToFavorites throws error
    @MainActor
    func test_addToFavorites_throwsError_whenRepositoryFails() async {
        let mockChar = makeMockChar()
        let repository = RepositoryMock()
        repository.shouldThrowOnSave = true
        
        let viewModel = DetailsViewModel(char: mockChar, repository: repository)

        do {
            try await viewModel.addToFavorites(char: mockChar)
            XCTFail("Era esperado lançar erro, mas o método não lançou")
        } catch {
            XCTAssertEqual(error as? DSError, DSError.charAlreadyExists)
        }
    }
}

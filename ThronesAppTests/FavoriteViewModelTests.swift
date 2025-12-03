//
//  FavoriteViewModelTests.swift
//  ThronesAppTests
//
//  Created by Diggo Silva on 02/12/25.
//

import XCTest
@testable import ThronesApp

// MARK: - Delegate Mock
final class FavoriteViewModelDelegateMock: FavoriteViewModelDelegate {
    var reloadCalled = false
    func reloadTable() {
        reloadCalled = true
    }
}

// MARK: - FavoriteViewModel Tests
final class FavoriteViewModelTests: XCTestCase {
    
    private var delegateMock: FavoriteViewModelDelegateMock!
    private var repositoryMock: RepositoryMock!
    private var sut: FavoriteViewModel!
    
    override func setUp() {
        super.setUp()
        delegateMock = FavoriteViewModelDelegateMock()
        repositoryMock = RepositoryMock()
        sut = FavoriteViewModel(repository: repositoryMock)
        sut.setDelegate(delegateMock)
    }
    
    override func tearDown() {
        delegateMock = nil
        repositoryMock = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - TEST: loadChars
    func testLoadCharsShouldLoadCharsFromRepository() {
        repositoryMock.savedChars = [
            Char(id: 1, firstName: "Bob", lastName: "Esponja", fullName: "Bob Esponja", title: "", family: "", image: "", imageUrl: ""),
            Char(id: 2, firstName: "Patrick", lastName: "Estrela", fullName: "Patrick Estrela", title: "", family: "", image: "", imageUrl: "")
        ]
        
        sut.loadChars()
        
        XCTAssertEqual(sut.numberOfRows(), 2)
        XCTAssertEqual(sut.getChars()[0].fullName, "Bob Esponja")
        XCTAssertEqual(sut.getChars()[1].fullName, "Patrick Estrela")
        XCTAssertTrue(delegateMock.reloadCalled)
    }
    
    // MARK: - TEST: numberOfRows
    func testNumberOfRowsShouldReturnCorrectValue() {
        repositoryMock.savedChars = [
            Char(id: 1, firstName: "Bob", lastName: "Esponja", fullName: "Bob Esponja", title: "", family: "", image: "", imageUrl: ""),
            Char(id: 2, firstName: "Patrick", lastName: "Estrela", fullName: "Patrick Estrela", title: "", family: "", image: "", imageUrl: "")
        ]
        
        sut.loadChars()
        
        XCTAssertEqual(sut.numberOfRows(), 2)
    }
    
    // MARK: - TEST: cellForRow
    func testCellForRowShouldReturnCorrectChar() {
        repositoryMock.savedChars = [
            Char(id: 1, firstName: "Bob", lastName: "Esponja", fullName: "Bob Esponja", title: "", family: "", image: "", imageUrl: ""),
            Char(id: 2, firstName: "Patrick", lastName: "Estrela", fullName: "Patrick Estrela", title: "", family: "", image: "", imageUrl: "")
        ]
        
        sut.loadChars()
        
        let char = sut.cellForRow(at: 1)
        
        XCTAssertEqual(char.fullName, "Patrick Estrela")
    }
    
    // MARK: - TEST: removeChar
    func testRemoveCharShouldRemoveCorrectIndex() {
        repositoryMock.savedChars = [
            Char(id: 1, firstName: "Bob", lastName: "Esponja", fullName: "Bob Esponja", title: "", family: "", image: "", imageUrl: ""),
            Char(id: 2, firstName: "Patrick", lastName: "Estrela", fullName: "Patrick Estrela", title: "", family: "", image: "", imageUrl: "")
        ]
        
        sut.loadChars()
        sut.removeChar(at: 0)
        
        XCTAssertEqual(sut.numberOfRows(), 1)
        XCTAssertEqual(sut.getChars().first?.fullName, "Patrick Estrela")
    }
    
    // MARK: - TEST: saveChars
    func testSaveCharsShouldSaveAllCharsToRepository() {
        repositoryMock.savedChars = [
            Char(id: 1, firstName: "Bob", lastName: "Esponja", fullName: "Bob Esponja", title: "", family: "", image: "", imageUrl: "")
        ]
        
        sut.loadChars()
        sut.saveChars()
        
        XCTAssertEqual(repositoryMock.savedChars.count, 1)
        XCTAssertEqual(repositoryMock.savedChars[0].fullName, "Bob Esponja")
    }
    
    // MARK: - TEST: getChars
    func testGetCharsShouldReturnInternalArray() {
        repositoryMock.savedChars = [
            Char(id: 1, firstName: "Bob", lastName: "Esponja", fullName: "Bob Esponja", title: "", family: "", image: "", imageUrl: "")
        ]
        
        sut.loadChars()
        
        let chars = sut.getChars()
        
        XCTAssertEqual(chars.count, 1)
        XCTAssertEqual(chars.first?.fullName, "Bob Esponja")
    }
}

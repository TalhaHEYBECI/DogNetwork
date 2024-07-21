//
//  FetchRandomDogImageUseCaseTests.swift
//  DogNetworkTests
//
//  Created by talha heybeci on 21.07.2024.
//

import XCTest
import Combine
@testable import DogNetwork

class FetchRandomDogImageUseCaseTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        Logger.shared.enableLogging(true)
    }
    
    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchRandomDogImageUseCaseSuccess() {
        // Arrange
        let repository = DogRepository(apiService: DogAPIServiceMock())
        let useCase = FetchRandomDogImageUseCase(repository: repository)
        let expectation = XCTestExpectation(description: "Fetch random dog image")
        Logger.shared.log(message: "Test started: Fetch random dog image use case success")
        
        // Act
        useCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.shared.log(message: "Use case finished successfully")
                case .failure(let error):
                    Logger.shared.log(message: "Use case failed with error: \(error)")
                    XCTFail("Expected success, but got error \(error)")
                }
            }, receiveValue: { dog in
                // Assert
                Logger.shared.log(message: "Received dog: \(dog)")
                XCTAssertEqual(dog.status, "success")
                XCTAssertTrue(dog.message.contains("https://"))
                Logger.shared.log(message: "Assertion passed")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

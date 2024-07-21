//
//  DogAPIServiceTests.swift
//  DogNetworkTests
//
//  Created by talha heybeci on 21.07.2024.
//

import XCTest
import Combine
@testable import DogNetwork

class DogAPIServiceTests: XCTestCase {
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
    
    func testFetchRandomDogImageSuccess() {
        // Arrange
        let service = DogAPIServiceMock()
        let expectation = XCTestExpectation(description: "Fetch random dog image")
        Logger.shared.log(message: "Test started: Fetch random dog image success")
        
        // Act
        service.fetchRandomDogImage(request: FetchRandomDogImageRequest())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.shared.log(message: "Request finished successfully")
                case .failure(let error):
                    Logger.shared.log(message: "Request failed with error: \(error)")
                    XCTFail("Expected success, but got error \(error)")
                }
            }, receiveValue: { response in
                // Assert
                Logger.shared.log(message: "Received response: \(response)")
                XCTAssertEqual(response.status, "success")
                XCTAssertTrue(response.message.contains("https://"))
                Logger.shared.log(message: "Assertion passed")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

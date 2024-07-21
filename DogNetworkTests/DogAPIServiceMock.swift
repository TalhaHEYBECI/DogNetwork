//
//  DogAPIServiceMock.swift
//  DogNetworkTests
//
//  Created by talha heybeci on 21.07.2024.
//

import Foundation
import Combine
@testable import DogNetwork

class DogAPIServiceMock: DogAPIServiceProtocol {
    var fetchRandomDogImageResult: Result<FetchRandomDogImageResponse, Error> = .success(FetchRandomDogImageResponse(message: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg", status: "success"))
    
    func fetchRandomDogImage(request: FetchRandomDogImageRequest) -> AnyPublisher<FetchRandomDogImageResponse, Error> {
        return Future { promise in
            promise(self.fetchRandomDogImageResult)
        }.eraseToAnyPublisher()
    }
}

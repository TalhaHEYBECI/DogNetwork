//
//  DogRepository.swift
//  DogNetwork
//
//  Created by talha heybeci on 21.07.2024.
//

import Foundation
import Combine

public protocol DogRepositoryProtocol {
    func fetchRandomDogImage() -> AnyPublisher<Dog, Error>
}

public class DogRepository: DogRepositoryProtocol {
    private let apiService: DogAPIServiceProtocol
    
    public init(apiService: DogAPIServiceProtocol = DogAPIService()) {
        self.apiService = apiService
    }
    
    public func fetchRandomDogImage() -> AnyPublisher<Dog, Error> {
        let request = FetchRandomDogImageRequest()
        return apiService.fetchRandomDogImage(request: request)
            .map { response in
                Dog(message: response.message, status: response.status)
            }
            .eraseToAnyPublisher()
    }
}


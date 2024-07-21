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
        Logger.shared.log(message: "Fetching random dog image from repository", level: .debug)
        let request = FetchRandomDogImageRequest()
        return apiService.fetchRandomDogImage(request: request)
            .map { response in
                Dog(message: response.message, status: response.status)
            }
            .handleEvents(receiveSubscription: { _ in
                Logger.shared.log(message: "Started fetching random dog image in repository", level: .info)
            }, receiveOutput: { dog in
                Logger.shared.log(message: "Received dog: \(dog)", level: .debug)
            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.shared.log(message: "Finished fetching random dog image in repository", level: .info)
                case .failure(let error):
                    Logger.shared.log(message: "Failed fetching random dog image in repository with error: \(error)", level: .error)
                }
            }, receiveCancel: {
                Logger.shared.log(message: "Cancelled fetching random dog image in repository", level: .warning)
            })
            .eraseToAnyPublisher()
    }
}

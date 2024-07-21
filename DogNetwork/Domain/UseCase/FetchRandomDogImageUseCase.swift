//
//  FetchRandomDogImageUseCase.swift
//  DogNetwork
//
//  Created by talha heybeci on 21.07.2024.
//

import Foundation
import Combine

public protocol FetchRandomDogImageUseCaseProtocol {
    func execute() -> AnyPublisher<Dog, Error>
}

public class FetchRandomDogImageUseCase: FetchRandomDogImageUseCaseProtocol {
    private let repository: DogRepositoryProtocol
    
    public init(repository: DogRepositoryProtocol = DogRepository()) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<Dog, Error> {
        Logger.shared.log(message: "Executing fetch random dog image use case", level: .debug)
        return repository.fetchRandomDogImage()
            .handleEvents(receiveSubscription: { _ in
                Logger.shared.log(message: "Started fetch random dog image use case", level: .info)
            }, receiveOutput: { dog in
                Logger.shared.log(message: "Received dog in use case: \(dog)", level: .debug)
            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.shared.log(message: "Finished fetch random dog image use case", level: .info)
                case .failure(let error):
                    Logger.shared.log(message: "Failed fetch random dog image use case with error: \(error)", level: .error)
                }
            }, receiveCancel: {
                Logger.shared.log(message: "Cancelled fetch random dog image use case", level: .warning)
            })
            .eraseToAnyPublisher()
    }
}


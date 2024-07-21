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
        repository.fetchRandomDogImage()
    }
}

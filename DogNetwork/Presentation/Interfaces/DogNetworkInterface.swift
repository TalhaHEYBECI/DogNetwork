//
//  DogNetworkInterface.swift
//  DogNetwork
//
//  Created by talha heybeci on 21.07.2024.
//

import Foundation
import Combine

public class DogNetworkInterface: ObservableObject {
    @Published public var dogImageURL: String = ""
    @Published public var errorMessage: String = ""
    
    private let fetchRandomDogImageUseCase: FetchRandomDogImageUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(fetchRandomDogImageUseCase: FetchRandomDogImageUseCaseProtocol = FetchRandomDogImageUseCase()) {
        self.fetchRandomDogImageUseCase = fetchRandomDogImageUseCase
    }
    
    public func fetchRandomDogImage() {
        fetchRandomDogImageUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { dog in
                self.dogImageURL = dog.message
            })
            .store(in: &cancellables)
    }
}

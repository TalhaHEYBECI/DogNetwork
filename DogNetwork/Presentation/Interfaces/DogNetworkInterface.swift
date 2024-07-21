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
        Logger.shared.log(message: "Fetching random dog image in Interface", level: .debug)
        fetchRandomDogImageUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.shared.log(message: "Finished fetching random dog image in Interface", level: .info)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    Logger.shared.log(message: "Failed fetching random dog image in Interface with error: \(error)", level: .error)
                }
            }, receiveValue: { dog in
                self.dogImageURL = dog.message
                Logger.shared.log(message: "Received dog image URL in Interface: \(dog.message)", level: .debug)
            })
            .store(in: &cancellables)
    }
}

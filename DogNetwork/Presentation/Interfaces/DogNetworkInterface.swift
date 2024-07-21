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
    public var imageUpdated = PassthroughSubject<Void, Never>()
    

    private let fetchRandomDogImageUseCase: FetchRandomDogImageUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    

    public init(fetchRandomDogImageUseCase: FetchRandomDogImageUseCaseProtocol = FetchRandomDogImageUseCase()) {
        self.fetchRandomDogImageUseCase = fetchRandomDogImageUseCase
    }
    

    public func fetchRandomDogImage() {
        Logger.shared.logStart()
        Logger.shared.log(message: "Fetching random dog image", alwaysLog: true)
        fetchRandomDogImageUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.shared.log(message: "Finished fetching random dog image", alwaysLog: true)
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                    Logger.shared.log(message: "Error fetching random dog image: \(error.localizedDescription)", level: .error, alwaysLog: true)
                }
                Logger.shared.logEnd()
            }, receiveValue: { dog in
                DispatchQueue.main.async {
                    self.dogImageURL = dog.message
                    self.errorMessage = ""
                    Logger.shared.log(message: "Received dog image URL: \(dog.message)", alwaysLog: true)
                }
                self.imageUpdated.send()
            })
            .store(in: &cancellables)
    }
}

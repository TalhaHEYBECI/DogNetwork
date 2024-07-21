//
//  DogAPIService.swift
//  DogNetwork
//
//  Created by talha heybeci on 21.07.2024.
//

import Foundation
import Combine

public protocol DogAPIServiceProtocol {
    func fetchRandomDogImage(request: FetchRandomDogImageRequest) -> AnyPublisher<FetchRandomDogImageResponse, Error>
}

public class DogAPIService: DogAPIServiceProtocol {
    private let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
    
    public init() {}
    
    public func fetchRandomDogImage(request: FetchRandomDogImageRequest) -> AnyPublisher<FetchRandomDogImageResponse, Error> {
        Logger.shared.log(message: "Fetching random dog image from URL: \(url)", level: .debug)
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: FetchRandomDogImageResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { _ in
                Logger.shared.log(message: "Started fetching random dog image", level: .info)
            }, receiveOutput: { response in
                Logger.shared.log(message: "Received response: \(response)", level: .debug)
            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    Logger.shared.log(message: "Finished fetching random dog image", level: .info)
                case .failure(let error):
                    Logger.shared.log(message: "Failed fetching random dog image with error: \(error)", level: .error)
                }
            }, receiveCancel: {
                Logger.shared.log(message: "Cancelled fetching random dog image", level: .warning)
            })
            .eraseToAnyPublisher()
    }
}


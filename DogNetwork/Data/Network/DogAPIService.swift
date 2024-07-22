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
    public init() {}

    public func fetchRandomDogImage(request: FetchRandomDogImageRequest) -> AnyPublisher<FetchRandomDogImageResponse, Error> {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: FetchRandomDogImageResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

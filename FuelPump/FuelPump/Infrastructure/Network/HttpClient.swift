//
//  HttpClient.swift
//  FuelPump
//
//  Created by Jose Mari on 17/1/23.
//

import Foundation
import Combine

protocol HTTPClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> AnyPublisher<T,Error>
}

class HTTPClient: HTTPClientProtocol {

    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> AnyPublisher<T,Error> {
        var urlComponents = URLComponents()

        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        guard let url = urlComponents.url else {
            return Fail(error: RequestError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .flatMap { data, response -> AnyPublisher<T, Error> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: RequestError.decode).eraseToAnyPublisher()
                }

                switch httpResponse.statusCode {
                case 200...299:
                    guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                        return Fail(error: RequestError.decode).eraseToAnyPublisher()
                    }
                    return Just(decodedResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
                case 401:
                    return Fail(error: RequestError.unauthorized).eraseToAnyPublisher()
                default:
                    return Fail(error: RequestError.error(statusCode: httpResponse.statusCode, data: data)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

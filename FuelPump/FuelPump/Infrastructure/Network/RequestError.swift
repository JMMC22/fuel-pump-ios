//
//  RequestError.swift
//  FuelPump
//
//  Created by Jose Mari on 17/1/23.
//

import Foundation

enum RequestError: Error {
    case error(statusCode: Int, data: Data?)
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
}

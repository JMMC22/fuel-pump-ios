//
//  GasStationEndpoint.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation

enum GasStationEndpoint {
    case getAll
}

extension GasStationEndpoint: Endpoint {

    var host: String {
        return try! Configuration.value(for: .apiBaseUrl)
    }

    var header: [String : String]? {
        switch self {
        case .getAll:
            return nil
        }
    }

    var path: String {
        switch self {
        case .getAll:
            return "/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres"
        }
    }

    var method: HTTPMethodType {
        switch self {
        case .getAll:
            return .get
        }
    }

    var body: [String: String]? {
        switch self {
        case .getAll:
            return nil
        }
    }
}

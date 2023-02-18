//
//  GasStation.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation

struct GasStation: Equatable {
    let address: String
}

struct GetAllGasStation: Equatable {
    let date: String
    let gasStations: [GasStation]
}

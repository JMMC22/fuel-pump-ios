//
//  GasStation.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation

struct GasStation: Equatable, Hashable {
    let address: String
    let city: String
    let province: String
    let company: String
    let icon: String
}

struct GetAllGasStation: Equatable {
    let date: String
    let gasStations: [GasStation]
}

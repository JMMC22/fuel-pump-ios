//
//  GasStationListLink.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation

enum GasStationListLink: Hashable, Identifiable {

    case details(_ station: GasStation)

    var id: String {
        String(describing: self)
    }
}

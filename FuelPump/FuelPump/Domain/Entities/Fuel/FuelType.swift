//
//  FuelType.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 29/5/23.
//

import Foundation

enum FuelType: String, CaseIterable {
    case dieselA = "Diésel A"
    case dieselB = "Diésel B"
    case dieselPremium = "Diésel A+"
    case gasoline95_E5 = "Gasolina 95 E5"
    case gasoline95_E10 = "Gasolina 95 E10"
    case gasoline95_E5_Premium = "Gasolina 95 E5 Premium"
    case gasoline98_E5 = "Gasolina 98 E5"
    case gasoline98_E10 = "Gasolina 98 E10"
    case unknown
}

extension FuelType: Identifiable {
    var id: String {
        return rawValue
    }
}

extension FuelType {
    var description: String {
        switch self {
        case .dieselA:
            return "dieselA"
        case .dieselB:
            return "dieselB"
        case .dieselPremium:
            return "dieselPremium"
        case .gasoline95_E5:
            return "gasoline95_E5"
        case .gasoline95_E10:
            return "gasoline95_E10"
        case .gasoline95_E5_Premium:
            return "gasoline95_E5_Premium"
        case .gasoline98_E5:
            return "gasoline98_E5"
        case .gasoline98_E10:
            return "gasoline98_E10"
        case .unknown:
            return ""
        }
    }
}

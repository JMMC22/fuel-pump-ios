//
//  GasStationCellViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation
import SwiftUI

class GasStationCellViewModel: ObservableObject {

    @Published var companyIcon: String = ""
    @Published var companyName: String = ""
    @Published var address: String = ""
    @Published var price: String = ""
    @Published var color: Color = .green

    private let gasStation: GasStation
    private let favouriteFuel: FuelType

    init(gasStation: GasStation, fuel: FuelType, maxPrice: Double, minPrice: Double) {
        self.gasStation = gasStation
        self.favouriteFuel = fuel
        self.companyIcon = gasStation.icon
        self.companyName = gasStation.company
        self.address = gasStation.address
        self.price = String(gasStation.getFavouriteFuelPrice(favouriteFuel)) + " €/L"
        let range = gasStation.getFuelRange(favouriteFuel, maxPrice: maxPrice, minPrice: minPrice)
        self.color = range == .high ? .redStatus : range == .middle ? .orangeStatus : .greenStatus
    }
}

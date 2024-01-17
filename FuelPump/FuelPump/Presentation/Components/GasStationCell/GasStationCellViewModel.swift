//
//  GasStationCellViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation

class GasStationCellViewModel: ObservableObject {
    
    @Published var companyIcon: String = ""
    @Published var companyName: String = ""
    @Published var address: String = ""
    @Published var price: String = ""

    private let gasStation: GasStation
    private let favouriteFuel: FuelType

    init(gasStation: GasStation, favouriteFuel: FuelType) {
        self.gasStation = gasStation
        self.favouriteFuel = favouriteFuel
        self.companyIcon = gasStation.icon
        self.companyName = gasStation.company
        self.address = gasStation.address
        self.price = String(gasStation.getFavouriteFuelPrice(favouriteFuel)) + " €/L"
    }
}

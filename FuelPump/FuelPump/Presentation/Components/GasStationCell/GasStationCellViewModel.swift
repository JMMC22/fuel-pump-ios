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
    @Published var distance: String = ""

    private let gasStation: GasStation
    private let favouriteFuel: FuelType
    private let locationManager: LocationManager

    init(gasStation: GasStation, fuel: FuelType, maxPrice: Double, minPrice: Double, locationManager: LocationManager = .shared) {
        self.gasStation = gasStation
        self.locationManager = locationManager
        self.favouriteFuel = fuel
        self.companyIcon = gasStation.icon
        self.companyName = gasStation.company
        self.address = gasStation.address
        self.price = String(gasStation.getFavouriteFuelPrice(favouriteFuel)) + " €/L"
        let range = gasStation.getFuelRange(favouriteFuel, maxPrice: maxPrice, minPrice: minPrice)
        self.color = range == .high ? .redStatus : range == .middle ? .orangeStatus : .greenStatus
        let distance = locationManager.getDistance(to: gasStation.location)
        self.distance = distance < 1000 ? "\(distance) m" : String(format: "%.1f km", (distance / 1000))
    }
}

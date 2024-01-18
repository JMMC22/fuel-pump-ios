//
//  Location.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 20/5/23.
//

import Foundation
import CoreLocation

struct Location: Equatable, Hashable {
    let latitude: String
    let longitude: String
}

extension Location {
    func calculateDistance(to destination: Location) -> Double {
        let sourceLocation = CLLocation(latitude: Double(self.latitude) ?? 0.0, longitude: Double(self.longitude) ?? 0.0)
        let destinationLocation = CLLocation(latitude: Double(destination.latitude) ?? 0.0, longitude: Double(destination.longitude) ?? 0.0)
        return sourceLocation.distance(from: destinationLocation)
    }
}

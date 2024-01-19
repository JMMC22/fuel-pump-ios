//
//  GetAllGasStation.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation

struct GetAllGasStation: Equatable {
    let date: String
    let gasStations: [GasStation]
}

extension GetAllGasStation {
    func mapToRealmObject() -> GetAllGasStationRealm {
        let model = GetAllGasStationRealm()
        model._date = date
        model.gasStations.append(objectsIn: gasStations.map({ $0.mapToRealmObject() }))
        return model
    }
    
    static func mapFromRealmObject(_ gasStation: GetAllGasStationRealm) -> GetAllGasStation {
        return GetAllGasStation(date: gasStation._date,
                                gasStations: gasStation.gasStations.map({ GasStation.mapFromRealmObject($0) }))
    }
}

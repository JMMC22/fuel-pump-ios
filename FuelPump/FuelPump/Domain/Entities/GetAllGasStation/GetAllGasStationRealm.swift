//
//  GetAllGasStationRealm.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation
import RealmSwift

class GetAllGasStationRealm: Object {
    @Persisted(primaryKey: true) var _date: String
    @Persisted var gasStations: List<GasStationRealm>
}

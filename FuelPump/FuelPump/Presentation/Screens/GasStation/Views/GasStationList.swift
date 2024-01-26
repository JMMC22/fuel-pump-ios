//
//  GasStationList.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 18/1/24.
//

import Foundation
import SwiftUI

struct GasStationList: View {

    let result: GasStationsResult
    let favouriteFuel: FuelType
    let isLoading: Bool
    let showDetails: (GasStation) -> ()

    var body: some View {
        LazyVStack(spacing: 16) {
            ForEach(result.gasStations, id: \.self) { gasStation in
                GasStationCell(gasStation: gasStation,
                               fuel: favouriteFuel,
                               maxPrice: result.maxPrice,
                               minPrice: result.minPrice)
                .onTapGesture {
                    showDetails(gasStation)
                }
            }
            .redacted(reason: isLoading ? .placeholder : [])
        }
    }
}

struct GasStationList_Previews: PreviewProvider {
    static var previews: some View {
        GasStationList(result: GasStationsResult(gasStations: GasStation.mockedData,
                                                 maxPrice: 1.8, minPrice: 1.0, date: ""),
                       favouriteFuel: .dieselA,
                       isLoading: false) { _ in }
    }
}

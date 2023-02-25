//
//  GasStationList.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import SwiftUI

struct GasStationListView: View {

    @ObservedObject private(set) var viewModel: GasStationListViewModel

    var body: some View {
        GasStationList(gasStations: viewModel.gasStations)
            .task {
                await viewModel.getAllGasStation()
            }
    }
}

struct GasStationList: View {

    var gasStations: [GasStation]

    var body: some View {
        List {
            ForEach(gasStations, id: \.self) { gasStation in
                GasStationCell(gasStation: gasStation)
            }
        }
    }
}

struct GasStationList_Previews: PreviewProvider {
    static var previews: some View {
        GasStationList(gasStations: GasStation.mockedData)
    }
}

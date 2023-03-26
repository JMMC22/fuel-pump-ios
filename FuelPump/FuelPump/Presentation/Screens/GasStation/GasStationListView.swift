//
//  GasStationList.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import SwiftUI

struct GasStationListView: View {

    @StateObject var viewModel: GasStationListViewModel

    var body: some View {
        GasStationList(gasStations: viewModel.gasStations,
                       isLoading: viewModel.isLoading)
            .alert(isPresented: $viewModel.error) {
                Alert(title: Text("Error"),
                      message: Text ("Vaya, parece que ha habido un error."),
                      dismissButton: .default(Text("OK")))
            }
            .onAppear {
                viewModel.getAllGasStations()
            }
    }
}

struct GasStationList: View {

    var gasStations: [GasStation]
    var isLoading: Bool

    var body: some View {
        List {
            ForEach(gasStations, id: \.self) { gasStation in
                GasStationCell(gasStation: gasStation)
            }
            .redacted(reason: isLoading ? .placeholder : [])
        }
    }
}

struct GasStationList_Previews: PreviewProvider {
    static var previews: some View {
        GasStationList(gasStations: GasStation.mockedData, isLoading: false)
    }
}

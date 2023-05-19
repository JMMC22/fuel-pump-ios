//
//  ContentView.swift
//  FuelPump
//
//  Created by Jose Mari on 10/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group {
            goToGasStationList()
        }
    }
}

private extension ContentView {
    func goToGasStationList() -> some View {
        let gasStationRepository = DefaultGasStationRepository()
        let getGasStationsUseCase = DefaultGetGasStationsUseCase(gasStationRepository: gasStationRepository)
        let getAllGasStationsUseCase = DefaultGetAllGasStationsUseCase(gasStationRepository: gasStationRepository)
        let gasStationListViewModel = GasStationListViewModel(getAllGasStationsUseCase: getAllGasStationsUseCase,
                                                              getGasStationsUseCase: getGasStationsUseCase)
        return GasStationListView(viewModel: gasStationListViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

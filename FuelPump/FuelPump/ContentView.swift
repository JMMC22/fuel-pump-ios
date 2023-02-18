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
        var repository = DefaultGasStationRepository()
        var useCase = DefaultGetGasStationsUseCase(gasStationRepository: repository)
        var viewModel = GasStationListViewModel(getGasStationsUseCase: useCase)
        return GasStationList(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

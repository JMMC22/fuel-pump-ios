//
//  GasStationList.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import SwiftUI

struct GasStationListView: View {

    @StateObject private var viewModel: GasStationListViewModel

    init() {
        let getGasStationsUseCase = DefaultGetGasStationsUseCase(gasStationRepository: DefaultGasStationRepository())
        let getUserUseCase = DefaultGetUserUseCase(userRepository: DefaultUserRepository())
        let gasStationListViewModel = GasStationListViewModel(getGasStationsUseCase: getGasStationsUseCase,
                                                              getUserUseCase: getUserUseCase)
        self._viewModel = StateObject(wrappedValue: gasStationListViewModel)
    }

    var body: some View {
        GasStationList(gasStations: viewModel.result.gasStations,
                       favouriteFuel: viewModel.favouriteFuel,
                       isLoading: viewModel.isLoading)
            .alert(isPresented: $viewModel.error) {
                Alert(title: Text("Error"),
                      message: Text ("Vaya, parece que ha habido un error."),
                      dismissButton: .default(Text("OK")))
            }
            .task {
                viewModel.viewDidLoad()
            }
    }
}

struct GasStationList: View {

    let gasStations: [GasStation]
    let favouriteFuel: FuelType
    let isLoading: Bool

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(gasStations, id: \.self) { gasStation in
                    GasStationCell(gasStation: gasStation, favouriteFuel: favouriteFuel)
                }
                .redacted(reason: isLoading ? .placeholder : [])
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
    }
}

struct GasStationList_Previews: PreviewProvider {
    static var previews: some View {
        GasStationList(gasStations: GasStation.mockedData, favouriteFuel: .dieselA, isLoading: false)
    }
}

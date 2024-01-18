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
        GasStationList(result: viewModel.result,
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

    let result: GasStationsResult
    let favouriteFuel: FuelType
    let isLoading: Bool

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(result.gasStations, id: \.self) { gasStation in
                    GasStationCell(gasStation: gasStation,
                                   fuel: favouriteFuel,
                                   maxPrice: result.maxPrice,
                                   minPrice: result.minPrice)
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
        GasStationList(result: GasStationsResult(gasStations: GasStation.mockedData,
                                                 maxPrice: 1.8, minPrice: 1.0),
                       favouriteFuel: .dieselA,
                       isLoading: false)
    }
}

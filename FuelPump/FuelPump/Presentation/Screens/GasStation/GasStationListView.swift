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
        let gasStationRepository = DefaultGasStationRepository()
        let getGasStationsUseCase = DefaultGetGasStationsUseCase(gasStationRepository: gasStationRepository)
        let getAllGasStationsUseCase = DefaultGetAllGasStationsUseCase(gasStationRepository: gasStationRepository)
        let gasStationListViewModel = GasStationListViewModel(getAllGasStationsUseCase: getAllGasStationsUseCase,
                                                              getGasStationsUseCase: getGasStationsUseCase)
        self._viewModel = StateObject(wrappedValue: GasStationListViewModel(getAllGasStationsUseCase: getAllGasStationsUseCase,
                                                                            getGasStationsUseCase: getGasStationsUseCase))
    }

    var body: some View {
        GasStationList(gasStations: viewModel.gasStations,
                       isLoading: viewModel.isLoading)
            .alert(isPresented: $viewModel.error) {
                Alert(title: Text("Error"),
                      message: Text ("Vaya, parece que ha habido un error."),
                      dismissButton: .default(Text("OK")))
            }
            .onAppear {
                viewModel.viewDidLoad()
            }
    }
}

struct GasStationList: View {

    var gasStations: [GasStation]
    var isLoading: Bool

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(gasStations, id: \.self) { gasStation in
                    GasStationCell(gasStation: gasStation)
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
        GasStationList(gasStations: GasStation.mockedData, isLoading: false)
    }
}

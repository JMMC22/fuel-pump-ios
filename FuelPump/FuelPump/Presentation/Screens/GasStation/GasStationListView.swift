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
        let gasStationListViewModel = GasStationListViewModel(getGasStationsUseCase: getGasStationsUseCase)
        self._viewModel = StateObject(wrappedValue: gasStationListViewModel)
    }

    var body: some View {
        GasStationListFlowCoordinator(state: viewModel, content: content)
    }

    private func content() -> some View {
        GasStationList(gasStations: viewModel.gasStations,
                       isLoading: viewModel.isLoading,
                       viewModel: viewModel)
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

    var gasStations: [GasStation]
    var isLoading: Bool
    @ObservedObject var viewModel: GasStationListViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(gasStations, id: \.self) { gasStation in
                    GasStationCell(gasStation: gasStation)
                        .onTapGesture {
                            viewModel.navigateToGasStationDetails(gasStation)
                        }
                }
                .redacted(reason: isLoading ? .placeholder : [])
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
    }
}

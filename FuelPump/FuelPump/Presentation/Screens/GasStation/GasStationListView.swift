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
        GasStationListFlowCoordinator(state: viewModel, content: content)
    }

    private func content() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                title
                list
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("Error"),
                  message: Text ("Vaya, parece que ha habido un error."),
                  dismissButton: .default(Text("OK")))
        }
        .task {
            viewModel.viewDidLoad()
        }
    }

    private var title: some View {
        Text("list.title")
            .fpTextStyle(.heading1, color: .black)
    }

    private var list: some View {
        GasStationList(result: viewModel.result,
                       favouriteFuel: viewModel.favouriteFuel,
                       isLoading: viewModel.isLoading) { station in
            viewModel.navigateToGasStationDetails(station)
        }
    }
}

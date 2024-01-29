//
//  GasStationList.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import SwiftUI

struct GasStationListView: View {

    @Environment(\.scenePhase) var scenePhase

    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel: GasStationListViewModel

    init() {
        let getGasStationsUseCase = DefaultGetGasStationsUseCase(gasStationRepository: DefaultGasStationRepository())
        let getUserUseCase = DefaultGetUserUseCase(userRepository: DefaultUserRepository())
        let gasStationListViewModel = GasStationListViewModel(getGasStationsUseCase: getGasStationsUseCase,
                                                              getUserUseCase: getUserUseCase)
        self._viewModel = StateObject(wrappedValue: gasStationListViewModel)
    }

    var body: some View {
        content()
    }

    private func content() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                lastUpdate
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
        .toolbar(.hidden)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                viewModel.viewDidLoad()
            }
        }
    }

    private var lastUpdate: some View {
        Text(viewModel.result.date)
            .FPFont(.Inter(12, weight: .regular), color: .textGray)
    }

    private var title: some View {
        Text("list.title")
            .FPFont(.Inter(24, weight: .bold), color: .black)
    }

    private var list: some View {
        GasStationList(result: viewModel.result,
                       favouriteFuel: viewModel.favouriteFuel,
                       isLoading: viewModel.isLoading) { station in
            coordinator.presentedItem = .gasStationDetails(station)
        }
    }
}

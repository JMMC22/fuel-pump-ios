//
//  Onboarding.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 6/7/23.
//

import SwiftUI

struct OnboardingView: View {

    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel: OnboardingViewModel

    init() {
        let gasStationRepository = DefaultGasStationRepository()
        let fetchAllGasStationsUseCase = DefaultFetchAllGasStationsUseCase(gasStationRepository: gasStationRepository)
        self._viewModel = StateObject(wrappedValue: OnboardingViewModel(fetchAllGasStationsUseCase: fetchAllGasStationsUseCase))
    }

    var body: some View {
        VStack {

            Image("onboarding")

            VStack(spacing: 24) {
                Text("onboarding.welcome")
                    .fpTextStyle(.heading1, color: .black)
                Text("onboarding.description")
                    .fpTextStyle(.description, color: .textGray)
                Text("onboarding.permissions")
                    .fpTextStyle(.description, color: .textGray)
            }
            .multilineTextAlignment(.center)
            .padding(.top, 65)

            Spacer()

            FPButton(text: "button.next", action: {
                coordinator.push(.fuelselector)
            })
            .disabled(viewModel.isButtonEnabled == false)
        }
        .padding(.vertical, 55)
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.viewDidLoad()
        }
        .toolbar(.hidden)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

//
//  OnboardingFuelSelectorView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 23/8/23.
//

import SwiftUI

struct OnboardingFuelSelectorView: View {

    @StateObject private var viewModel: OnboardingFuelSelectorViewModel

    init(viewModel: OnboardingFuelSelectorViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        OnboardingFuelSelectorFlowCoordinator(state: viewModel, content: content)
    }

    @ViewBuilder private func content() -> some View {
        VStack(alignment: .leading, spacing: 18) {

            Text("onboarding.selector.title" )
                .fpTextStyle(.heading1, color: .black)
            
            Text("onboarding.selector.subtitle" )
                .fpTextStyle(.description, color: .textGray)

            Spacer()

            FPButton(text: "button.next", action: {
                viewModel.navigateToGasStationList()
            })
        }
        .padding(.vertical, 51)
        .padding(.horizontal, 34)

    }
}

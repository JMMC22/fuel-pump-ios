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
        VStack {

            Text("Fuel Selector")

            Spacer()

            FPButton(text: "button.next", action: {
                viewModel.navigateToGasStationList()
            })
        }
        .padding(.vertical, 55)
        .padding(.horizontal, 16)

    }
}

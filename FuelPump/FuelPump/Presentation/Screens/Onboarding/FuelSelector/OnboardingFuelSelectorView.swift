//
//  OnboardingFuelSelectorView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 23/8/23.
//

import SwiftUI

struct OnboardingFuelSelectorView: View {

    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel: OnboardingFuelSelectorViewModel

    init() {
        self._viewModel = StateObject(wrappedValue: OnboardingFuelSelectorViewModel())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {

            Text("onboarding.selector.title" )
                .FPFont(.Inter(24, weight: .bold), color: .black)
            
            Text("onboarding.selector.subtitle" )
                .FPFont(.Inter(14, weight: .light), color: .textGray)

            ListSelector(options: viewModel.fuelOptions, selectedOption: $viewModel.fuelSelectedOption)

            Spacer()

            FPButton(text: "button.next", action: {
                viewModel.saveUserFuelSelection()
            })
        }
        .padding(.vertical, 51)
        .padding(.horizontal, 34)
        .onReceive(viewModel.$page) { page in
            if let page {
                coordinator.push(page)
            }
        }
        .toolbar(.hidden)
    }
}

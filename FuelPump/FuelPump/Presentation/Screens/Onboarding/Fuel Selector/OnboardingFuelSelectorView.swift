//
//  OnboardingFuelSelectorView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 23/8/23.
//

import SwiftUI

struct OnboardingFuelSelectorView: View {

    @StateObject private var viewModel: OnboardingFuelSelectorViewModel

    init() {
        self._viewModel = StateObject(wrappedValue: OnboardingFuelSelectorViewModel())
    }

    var body: some View {
        content()
    }

    @ViewBuilder private func content() -> some View {
        Text("Fuel Selector")
    }
}

struct OnboardingFuelSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFuelSelectorView()
    }
}

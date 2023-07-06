//
//  Onboarding.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 6/7/23.
//

import SwiftUI

struct OnboardingView: View {

    @StateObject private var viewModel: OnboardingViewModel

    init() {
        self._viewModel = StateObject(wrappedValue: OnboardingViewModel())
    }

    var body: some View {
        Text("OnboardingView")
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

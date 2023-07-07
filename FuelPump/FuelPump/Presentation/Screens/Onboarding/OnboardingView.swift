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

            FPButton(text: "Siguiente", action: {})
        }
        .padding(.vertical, 55)
        .padding(.horizontal, 16)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

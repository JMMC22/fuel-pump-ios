//
//  OnboardingFlowCoordinator.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 5/9/23.
//

import Foundation
import SwiftUI

struct OnboardingFlowCoordinator<Content: View>: View {

    @ObservedObject var state: OnboardingFlowState
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $state.path) {
            ZStack {
                content()
            }
            .navigationDestination(for: OnboardingLink.self, destination: linkDestination)
        }
    }

    @ViewBuilder private func linkDestination(link: OnboardingLink) -> some View {
        switch link {
        case .onboardingFuelSelector:
            onboardingFuelSelectorDestination()
        }
    }

    private func onboardingFuelSelectorDestination() -> some View {
        let view = OnboardingFuelSelectorView()
        return view
    }
}

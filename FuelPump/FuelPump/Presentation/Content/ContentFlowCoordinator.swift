//
//  ContentFlowCoordinator.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/7/23.
//

import Foundation
import SwiftUI

struct ContentFlowCoordinator<Content: View>: View {

    @ObservedObject var state: ContentFlowState
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $state.path) {
            ZStack {
                content()
            }
            .navigationDestination(for: ContentLink.self, destination: linkDestination)
        }
    }

    @ViewBuilder private func linkDestination(link: ContentLink) -> some View {
        switch link {
        case .splash:
            splashDestination()
        case .onboarding:
            onboardingDestination()
        }
    }

    private func splashDestination() -> some View {
        let view = SplashView()
        return view
    }

    private func onboardingDestination() -> some View {
        let view = OnboardingView()
        return view
    }
}

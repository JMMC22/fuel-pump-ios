//
//  OnboardingFuelSelectorFlowCoordinator.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 5/9/23.
//

import Foundation
import SwiftUI

struct OnboardingFuelSelectorFlowCoordinator<Content: View>: View {

    @ObservedObject var state: OnboardingFuelSelectorFlowState
    let content: () -> Content

    var body: some View {
        content()
            .navigationBarHidden(true)
            .navigationDestination(for: OnboardingFuelSelectorLink.self, destination: linkDestination)
    }

    @ViewBuilder private func linkDestination(link: OnboardingFuelSelectorLink) -> some View {
        switch link {
        case .gasStationsList:
            gasStationsListDestination()
        }
    }

    private func gasStationsListDestination() -> some View {
        let view = GasStationListView()
        return view
    }
}

//
//  OnboardingFuelSelectorViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 23/8/23.
//

import Foundation
import SwiftUI

final class OnboardingFuelSelectorViewModel: OnboardingFuelSelectorFlowState {

    override init(path: Binding<NavigationPath>) {
        super.init(path: path)
    }

    func navigateToGasStationList() {
        path.append(OnboardingFuelSelectorLink.gasStationsList)
    }
}

//
//  OnboardingFuelSelectorViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 23/8/23.
//

import Foundation
import SwiftUI

final class OnboardingFuelSelectorViewModel: OnboardingFuelSelectorFlowState {

    @Published var selectedOption: SelectorOption
    @Published var options: [SelectorOption] = [
        SelectorOption(key: "key1", value: "Valor 1"),
        SelectorOption(key: "key2", value: "Valor 2"),
        SelectorOption(key: "key3", value: "Valor 3")
    ]

    override init(path: Binding<NavigationPath>) {
        self.selectedOption = SelectorOption(key: "key1", value: "Valor 1")
        super.init(path: path)
    }

    func navigateToGasStationList() {
        path.append(OnboardingFuelSelectorLink.gasStationsList)
    }
}

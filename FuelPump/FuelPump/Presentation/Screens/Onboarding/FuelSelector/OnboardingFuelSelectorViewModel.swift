//
//  OnboardingFuelSelectorViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 23/8/23.
//

import Foundation
import SwiftUI

final class OnboardingFuelSelectorViewModel: OnboardingFuelSelectorFlowState {

    @Published var fuelOptions: [SelectorOption]
    @Published var fuelSelectedOption: SelectorOption

    override init(path: Binding<NavigationPath>) {
        self.fuelOptions = FuelType.allCases.map({ SelectorOption(key: $0.rawValue, value: $0.rawValue)})
        self.fuelSelectedOption = SelectorOption(key: FuelType.dieselA.rawValue, value: FuelType.dieselA.rawValue)
        super.init(path: path)
    }

    func navigateToGasStationList() {
        path.append(OnboardingFuelSelectorLink.gasStationsList)
    }

    func saveUserFuelSelection() {
        print("||DEBUG|| User selection: \(self.fuelSelectedOption)")
        navigateToGasStationList()
    }
}

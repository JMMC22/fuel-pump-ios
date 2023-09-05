//
//  OnboardingFuelSelectorFlowState.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 5/9/23.
//

import Foundation
import SwiftUI

open class OnboardingFuelSelectorFlowState: ObservableObject {
    @Published var presentedItem: OnboardingFuelSelectorLink?

    @Binding var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        _path = path
    }
}

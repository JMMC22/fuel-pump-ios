//
//  OnboardingFlowState.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 5/9/23.
//

import Foundation
import SwiftUI

open class OnboardingFlowState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedItem: OnboardingLink?
    @Published var coverItem: OnboardingLink?
    @Published var selectedLink: OnboardingLink?
}

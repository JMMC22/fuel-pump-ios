//
//  OnboardingLink.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 5/9/23.
//

import Foundation

enum OnboardingLink: Hashable, Identifiable {

    case onboardingFuelSelector

    var id: String {
        String(describing: self)
    }
}

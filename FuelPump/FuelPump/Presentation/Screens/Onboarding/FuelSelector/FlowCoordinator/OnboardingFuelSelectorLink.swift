//
//  OnboardingFuelSelectorLink.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 5/9/23.
//

import Foundation

enum OnboardingFuelSelectorLink: Hashable, Identifiable {

    case gasStationsList

    var id: String {
        String(describing: self)
    }
}

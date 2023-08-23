//
//  ContentLink.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/7/23.
//

import Foundation

enum ContentLink: Hashable, Identifiable {

    case splash
    case onboarding

    var id: String {
        String(describing: self)
    }
}

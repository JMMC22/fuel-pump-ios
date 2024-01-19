//
//  AppState.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/1/24.
//

import Foundation

class AppState: ObservableObject {
    @Published var state: AppState.State = .none
}

extension AppState {
    enum State {
        case checking
        case logged
        case none
    }
}

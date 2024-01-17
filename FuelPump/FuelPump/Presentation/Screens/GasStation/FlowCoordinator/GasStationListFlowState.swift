//
//  GasStationListFlowState.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation
import SwiftUI

open class GasStationListFlowState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedItem: GasStationListLink?
    @Published var coverItem: GasStationListLink?
    @Published var selectedLink: GasStationListLink?
}

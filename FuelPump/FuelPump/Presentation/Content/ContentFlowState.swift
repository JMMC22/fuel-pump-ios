//
//  ContentFlowState.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/7/23.
//

import Foundation
import SwiftUI

open class ContentFlowState: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedItem: ContentLink?
    @Published var coverItem: ContentLink?
    @Published var selectedLink: ContentLink?
}

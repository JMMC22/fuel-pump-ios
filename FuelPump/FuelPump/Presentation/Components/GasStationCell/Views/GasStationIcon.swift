//
//  GasStationIcon.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation
import SwiftUI

struct GasStationIcon: View {
    var iconName: String

    var body: some View {
        Image(iconName)
            .resizable()
            .frame(width: 25, height: 25)
            .padding(5)
            .aspectRatio(contentMode: .fit)
            .background(Color.white)
            .clipShape(Circle())
    }
}

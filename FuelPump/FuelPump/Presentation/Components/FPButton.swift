//
//  FPButton.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 7/7/23.
//

import Foundation
import SwiftUI

struct FPButton: View {

    let text: String
    let isDisabled: Bool
    let action: () -> Void

    init(text: String, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.text = text
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: { action() }, label: {
            Text(LocalizedStringKey(text))
                .fpTextStyle(.button, color: .white)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
        })
        .disabled(isDisabled)
        .tint(.primaryGreen)
        .buttonStyle(.borderedProminent)
    }
}

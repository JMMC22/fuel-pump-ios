//
//  ScaledFont.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/5/23.
//

import Foundation
import SwiftUI

struct ScaledFont: ViewModifier {

    @Environment(\.sizeCategory) var sizeCategory

    var type: FontType
    var weight: FontWeight
    var size: Double

    func scaledSize() -> CGFloat { UIFontMetrics.default.scaledValue(for: size) }

    func body(content: Content) -> some View {
        return content.font(Font.font(type: type, weight: weight, size: size))
    }
}

extension View {
    func scaledFont(type: FontType, weight: FontWeight, size: Double) -> some View {
        return self.modifier(ScaledFont(type: type, weight: weight, size: size))
    }
}

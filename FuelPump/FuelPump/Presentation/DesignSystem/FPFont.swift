//
//  FPFont.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 20/1/24.
//

import Foundation
import UIKit
import SwiftUI

struct FPFont {
    var font: UIFont

    static func Inter(_ size: CGFloat, weight: FontWeight) -> FPFont {
        let font = UIFont.font(type: .inter, weight: weight, size: size)
        return FPFont(font: font)
    }
}

struct FPFontModifier: ViewModifier {
    var font: FPFont
    var color: Color

    func body(content: Content) -> some View {
        content
            .textSelection(.enabled)
            .font(Font(self.font.font))
            .foregroundColor(color)
    }
}

extension View {
    func FPFont(_ font: FPFont, color: Color) -> some View {
        modifier(FPFontModifier(font: font, color: color))
    }
}

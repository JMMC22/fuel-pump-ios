//
//  FPTypography.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/5/23.
//

import Foundation
import SwiftUI

struct FPTypography: ViewModifier {

    enum FPTextStyle {
        case heading1, heading2, heading3, heading4
        case body
        case list
        case caption

        var standardSize: Double {
            switch self {
            case .heading1: return 24
            case .heading2: return 20
            case .heading3: return 18
            case .heading4: return 16
            case .body: return 18
            case .list: return 14
            case .caption: return 12
            }
        }
    }

    var style: FPTextStyle

    public func body(content: Content) -> some View {
        switch style {
        case .heading1: return content.scaledFont(type: .inter, weight: .bold, size: style.standardSize)
        case .heading2: return content.scaledFont(type: .inter, weight: .bold, size: style.standardSize)
        case .heading3: return content.scaledFont(type: .inter, weight: .bold, size: style.standardSize)
        case .heading4: return content.scaledFont(type: .inter, weight: .bold, size: style.standardSize)
        case .body: return content.scaledFont(type: .inter, weight: .regular, size: style.standardSize)
        case .list: return content.scaledFont(type: .inter, weight: .medium, size: style.standardSize)
        case .caption: return content.scaledFont(type: .inter, weight: .regular, size: style.standardSize)
        }
    }
}

extension View {

    func fpTextStyle(_ style: FPTypography.FPTextStyle) -> some View {
        self.modifier(FPTypography(style: style))
    }

    func fpTextStyle(_ style: FPTypography.FPTextStyle, color: Color) -> some View {
        self.modifier(FPTypography(style: style)).foregroundColor(color)
    }
}

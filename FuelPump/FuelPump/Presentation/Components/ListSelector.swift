//
//  ListSelector.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 6/9/23.
//

import SwiftUI

struct ListSelector: View {

    var options: [SelectorOption]
    @Binding var selectedOption: SelectorOption

    var body: some View {
        ForEach(options, id: \.key) { option in
            ListSelectorRow(option: option,
                            isOptionSelected: option == selectedOption) { option in
                selectedOption = option
            }
            Divider()
        }
    }
}

struct ListSelectorRow: View {

    let option: SelectorOption
    var isOptionSelected: Bool
    var onSelect: (_ option: SelectorOption) -> Void

    var body: some View {
        HStack {
            Text(option.value)
            Spacer()
            Image(isOptionSelected ? "selector-selected" : "selector-unselected")
        }
        .FPFont(.Inter(14, weight: .semiBold), color: .black)
        .onTapGesture {
            onSelect(option)
        }
    }
}

struct SelectorOption: Hashable {

    var key: String
    var value: String

    public static func == (lhs: SelectorOption, rhs: SelectorOption) -> Bool {
        return lhs.key == rhs.key
    }
}

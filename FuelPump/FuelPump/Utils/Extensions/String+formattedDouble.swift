//
//  String+formattedDouble.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 29/5/23.
//

import Foundation

extension String {
    var formattedDouble: Double {
        let formattedString = self.replacingOccurrences(of: ",", with: ".")
        return Double(formattedString) ?? 0.0
    }
}

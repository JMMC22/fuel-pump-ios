//
//  GasStationCell.swift
//  FuelPump
//
//  Created by Jose Mari on 25/2/23.
//

import SwiftUI

struct GasStationCell: View {

    var gasStation: GasStation

    var body: some View {
        HStack {
            VStack(
                alignment: .leading
            ) {
                Text(gasStation.address)
                    .font(.system(size: 14))
                Text(gasStation.city)
                    .font(.system(size: 12))
            }
            Spacer()
            GasStationIcon(iconName: gasStation.icon)
        }
    }
}

struct GasStationCell_Previews: PreviewProvider {
    static var previews: some View {
        GasStationCell(gasStation: GasStation.mockedData.first!)
    }
}

struct GasStationIcon: View {
    var iconName: String

    var body: some View {
        Image(iconName)
            .resizable()
            .frame(width: 25, height: 25)
            .aspectRatio(contentMode: .fit)
            .background(Color.white)
            .clipShape(Circle())
    }
}

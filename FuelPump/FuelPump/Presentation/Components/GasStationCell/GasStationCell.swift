//
//  GasStationCell.swift
//  FuelPump
//
//  Created by Jose Mari on 25/2/23.
//

import SwiftUI

struct GasStationCell: View {

    @StateObject private var viewModel: GasStationCellViewModel
    
    init(gasStation: GasStation, favouriteFuel: FuelType) {
        self._viewModel = StateObject(wrappedValue: GasStationCellViewModel(gasStation: gasStation,
                                                                            favouriteFuel: favouriteFuel))
    }

    var body: some View {
        HStack {
            GasStationIcon(iconName: viewModel.companyIcon)
            VStack(alignment: .leading) {
                Text(viewModel.companyName)
                    .fpTextStyle(.heading4)
                Text(viewModel.address)
                    .fpTextStyle(.caption, color: .textGray)
            }

            Spacer()

            Text(viewModel.price)
                .fpTextStyle(.heading4)
        }
        .padding(10)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.4), radius: 3)
    }
}

struct GasStationCell_Previews: PreviewProvider {
    static var previews: some View {
        GasStationCell(gasStation: GasStation.mockedData.first!, favouriteFuel: .dieselA)
    }
}

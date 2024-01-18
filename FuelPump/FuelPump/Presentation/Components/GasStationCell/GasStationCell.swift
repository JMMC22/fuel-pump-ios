//
//  GasStationCell.swift
//  FuelPump
//
//  Created by Jose Mari on 25/2/23.
//

import SwiftUI

struct GasStationCell: View {

    @StateObject private var viewModel: GasStationCellViewModel

    init(gasStation: GasStation, fuel: FuelType, maxPrice: Double, minPrice: Double) {
        self._viewModel = StateObject(wrappedValue: GasStationCellViewModel(gasStation: gasStation,
                                                                            fuel: fuel,
                                                                            maxPrice: maxPrice,
                                                                            minPrice: minPrice))
    }

    private var cornerRadius: CGFloat { return 5 }

    var body: some View {
        HStack {
            HStack {
                GasStationIcon(iconName: viewModel.companyIcon)
                VStack(alignment: .leading) {
                    Text(viewModel.companyName)
                        .fpTextStyle(.heading4)
                    Text(viewModel.address)
                        .fpTextStyle(.caption, color: .textGray)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 8)
            
            Spacer()

            Text(viewModel.price)
                .fpTextStyle(.heading4, color: .white)
                .padding()
                .background(
                    Rectangle()
                        .fill(viewModel.color)
                        .clipShape(
                            .rect(
                                topLeadingRadius: cornerRadius,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 0
                            )
                        )
                )
        }
        .background(.white)
        .clipShape(backgroundShape)
        .overlay(leftDivider, alignment: .leading)
        .shadow(color: .gray.opacity(0.4), radius: 2)
    }
    
    private var backgroundShape: some Shape {
        .rect(
            topLeadingRadius: cornerRadius,
            bottomLeadingRadius: cornerRadius,
            bottomTrailingRadius: cornerRadius,
            topTrailingRadius: 0
        )
    }

    private var leftDivider: some View {
        Rectangle()
            .fill(viewModel.color)
            .clipShape(
                .rect(
                    topLeadingRadius: cornerRadius,
                    bottomLeadingRadius: cornerRadius,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
            )
            .frame(width: 5)
    }
}

struct GasStationCell_Previews: PreviewProvider {
    static var previews: some View {
        GasStationCell(gasStation: GasStation.mockedData.first!, fuel: .dieselA, maxPrice: 1.8, minPrice: 1.0)
            .padding(16)
    }
}

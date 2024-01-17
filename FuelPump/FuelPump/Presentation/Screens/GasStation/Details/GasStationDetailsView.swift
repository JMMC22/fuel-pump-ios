//
//  GasStationDetailsView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import SwiftUI

struct GasStationDetailsView: View {

    @StateObject private var viewModel: GasStationDetailsViewModel

    init(_ station: GasStation) {
        self._viewModel = StateObject(wrappedValue: GasStationDetailsViewModel(station: station))
    }

    var body: some View {
        GasStationDetailsContainerView(companyName: viewModel.companyName,
                                       companyIcon: viewModel.companyIcon,
                                       address: viewModel.address,
                                       schedule: viewModel.schedule,
                                       prices: viewModel.fuelPrices)
    }
}

struct GasStationDetailsContainerView: View {

    let companyName: String
    let companyIcon: String
    let address: String
    let schedule: String
    let prices: [FuelType: Double]
    
    init(companyName: String, 
         companyIcon: String,
         address: String,
         schedule: String,
         prices: [FuelType: Double]) {
        self.companyName = companyName
        self.companyIcon = companyIcon
        self.address = address
        self.schedule = schedule
        self.prices = prices
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            companyContent
            informationContent
            pricesList
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var companyContent: some View {
        VStack(spacing: 8) {
            HStack {
                Text(companyName)
                    .fpTextStyle(.heading4, color: .black)
                Spacer()
                Image(companyIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Divider()
        }
    }
    
    private var informationContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                addressContent
                scheduleContent
            }
            Divider()
        }
    }

    private var addressContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("gas.station.details.address")
                .fpTextStyle(.list, color: .black)
            Text(address)
                .fpTextStyle(.description, color: .textGray)
        }
    }

    private var scheduleContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("gas.station.details.schedule")
                .fpTextStyle(.list, color: .black)
            Text(schedule)
                .fpTextStyle(.description, color: .textGray)
        }
    }

    private var pricesList: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(prices.map({ $0.key })) { fuel in
                if let price = prices[fuel], price.isZero == false {
                    HStack {
                        Text(fuel.rawValue)
                            .fpTextStyle(.heading4, color: .black)
                        Text(String(price) + " €/L")
                            .fpTextStyle(.heading4, color: .textGray)
                    }
                }
            }
        }
    }
}

struct GasStationDetailsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GasStationDetailsContainerView(companyName: "NOMBRE",
                                       companyIcon: "default-icon",
                                       address: "DIRECCIÓN",
                                       schedule: "L-D 24H",
                                       prices: [.dieselA: 1.5,
                                                .dieselB: 1.5,
                                                .gasoline95_E5: 1.5
                                               ])
    }
}

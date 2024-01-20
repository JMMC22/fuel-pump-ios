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
                                       distance: viewModel.distance,
                                       companyIcon: viewModel.companyIcon,
                                       address: viewModel.address,
                                       schedule: viewModel.schedule,
                                       prices: viewModel.fuelPrices,
                                       addressURL: viewModel.addressURL)
    }
}

struct GasStationDetailsContainerView: View {

    let companyName: String
    let distance: String
    let companyIcon: String
    let address: String
    let schedule: String
    let prices: [FuelType: Double]
    let addressURL: URL?

    init(companyName: String,
         distance: String,
         companyIcon: String,
         address: String,
         schedule: String,
         prices: [FuelType: Double],
         addressURL: URL?) {
        self.companyName = companyName
        self.distance = distance
        self.companyIcon = companyIcon
        self.address = address
        self.schedule = schedule
        self.prices = prices
        self.addressURL = addressURL
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            companyContent
            informationContent
            pricesList
            navigationButton
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 16, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var companyContent: some View {
        VStack(spacing: 8) {
            HStack {
                GasStationIcon(iconName: companyIcon)
                Text(companyName)
                    .FPFont(.Inter(16, weight: .bold), color: .black)
                Text(distance)
                    .FPFont(.Inter(14, weight: .semiBold), color: .black)
                Spacer()
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
                .FPFont(.Inter(14, weight: .semiBold), color: .black)
            Text(address)
                .FPFont(.Inter(14, weight: .light), color: .black)
        }
    }

    private var scheduleContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("gas.station.details.schedule")
                .FPFont(.Inter(14, weight: .semiBold), color: .black)
            Text(schedule)
                .FPFont(.Inter(14, weight: .light), color: .black)
        }
    }

    private var pricesList: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(FuelType.allCases) { fuel in
                if let price = prices[fuel], price.isZero == false {
                    HStack {
                        Text(fuel.rawValue)
                            .FPFont(.Inter(16, weight: .bold), color: .black)
                        Text(String(price) + " €/L")
                            .FPFont(.Inter(16, weight: .bold), color: .textGray)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var navigationButton: some View {
        if let addressURL {
            FPButton(text: "button.navigate.station") {
                if UIApplication.shared.canOpenURL(addressURL) {
                    UIApplication.shared.open(addressURL, options: [:], completionHandler: nil)
                }
            }
        }
    }
}

struct GasStationDetailsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GasStationDetailsContainerView(companyName: "NOMBRE",
                                       distance: "100 m",
                                       companyIcon: "default-icon",
                                       address: "DIRECCIÓN",
                                       schedule: "L-D 24H",
                                       prices: [.dieselA: 1.5,
                                                .dieselB: 1.5,
                                                .gasoline95_E5: 1.5
                                               ],
                                       addressURL: nil)
    }
}

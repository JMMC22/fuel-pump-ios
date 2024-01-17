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
                                       schedule: viewModel.schedule)
    }
}

struct GasStationDetailsContainerView: View {

    let companyName: String
    let companyIcon: String
    let address: String
    let schedule: String
    
    init(companyName: String, 
         companyIcon: String,
         address: String,
         schedule: String) {
        self.companyName = companyName
        self.companyIcon = companyIcon
        self.address = address
        self.schedule = schedule
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            companyContent
            informationContent
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
            addressContent
            scheduleContent
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
}

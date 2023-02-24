//
//  GasStationList.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import SwiftUI

struct GasStationList: View {

    @ObservedObject private(set) var viewModel: GasStationListViewModel

    var body: some View {
        List {
            ForEach(viewModel.gasStations, id: \.self) { gasStation in
                gasStationItemView(gasStation: gasStation)
            }
        }
        . task {
            await viewModel.getAllGasStation()
        }
    }

    func gasStationItemView(gasStation: GasStation) -> some View {
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

struct GasStationList_Previews: PreviewProvider {
    static var previews: some View {
        let repository = DefaultGasStationRepository()
        let useCase = DefaultGetGasStationsUseCase(gasStationRepository: repository)
        let viewModel = GasStationListViewModel(getGasStationsUseCase: useCase)
        GasStationList(viewModel: viewModel)
    }
}

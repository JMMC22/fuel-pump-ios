//
//  GasStationListFlowCoordinator.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation
import SwiftUI

struct GasStationListFlowCoordinator<Content: View>: View {

    @ObservedObject var state: GasStationListFlowState
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $state.path) {
            ZStack {
                content()
                    .sheet(item: $state.presentedItem, content: sheetContent)
            }
            .navigationDestination(for: GasStationListLink.self, destination: linkDestination)
        }
    }

    @ViewBuilder private func linkDestination(link: GasStationListLink) -> some View {
        switch link {
        case .details:
            gasStationsDetailsDestination()
        }
    }

    @ViewBuilder private func sheetContent(item: GasStationListLink) -> some View {
            switch item {
            case .details:
                gasStationsDetailsDestination()
            }
        }

    private func gasStationsDetailsDestination() -> some View {
        let view = GasStationDetailsView()
        return view
    }
}

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
    
    @State private var sheetHeight: CGFloat = 0

    var body: some View {
        NavigationStack(path: $state.path) {
            ZStack {
                content()
                    .sheet(item: $state.presentedItem) { item in
                        sheetContent(item: item)
                            .readHeight()
                            .onPreferenceChange(HeightPreferenceKey.self) { height in
                                if let height {
                                    self.sheetHeight = height
                                }
                            }
                            .presentationDetents([.height(self.sheetHeight)])
                    }
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

//
//  AppCoordinatorView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/1/24.
//

import SwiftUI

struct AppCoordinatorView: View {

    @StateObject private var coordinator = AppCoordinator()
    let rootPage: AppCoordinator.Page

    @State private var sheetHeight: CGFloat = 0

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: rootPage)
                .navigationDestination(for: AppCoordinator.Page.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.presentedItem) { sheet in
                    coordinator.build(page: sheet)
                        .readHeight()
                        .onPreferenceChange(HeightPreferenceKey.self) { height in
                            if let height {
                                self.sheetHeight = height
                            }
                        }
                        .presentationDetents([.height(self.sheetHeight)])
                }
        }
        .environmentObject(coordinator)
    }
}

//
//  MainView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 20/1/24.
//

import SwiftUI

struct MainView: View {

    @StateObject private var viewModel: MainViewModel

    init() {
        self._viewModel = StateObject(wrappedValue: MainViewModel())
    }

    var body: some View {
        TabView {

            // MARK: Home Tab
            AppCoordinatorView(rootPage: .gasStationsList)
                .tabItem {
                    Label("main.home", systemImage: "house")
                }

            // MARK: Settings Tab
            AppCoordinatorView(rootPage: .settings)
                .tabItem {
                    Label("main.settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainView()
}

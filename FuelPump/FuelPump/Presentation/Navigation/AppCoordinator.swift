//
//  AppCoordinator.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/1/24.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedItem: AppCoordinator.Page?
}

extension AppCoordinator {
    enum Page: Hashable, Identifiable {
        case fuelselector
        case gasStationDetails(_ station: GasStation)
        case gasStationsList
        case onboarding
        
        var id: String {
            String(describing: self)
        }
    }

    // MARK: - Navigate
    func push(_ page: AppCoordinator.Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    // MARK: - Sheet
    func present(_ page: AppCoordinator.Page) {
        presentedItem = page
    }

    func dismissSheet() {
        self.presentedItem = nil
    }
    
    @ViewBuilder
    func build(page: AppCoordinator.Page) -> some View {
        switch page {
        case .fuelselector:
            OnboardingFuelSelectorView()
        case .gasStationDetails(let station):
            GasStationDetailsView(station)
        case .gasStationsList:
            GasStationListView()
        case .onboarding:
            OnboardingView()
        }
    }
}



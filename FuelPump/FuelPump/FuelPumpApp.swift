//
//  FuelPumpApp.swift
//  FuelPump
//
//  Created by Jose Mari on 10/1/23.
//

import SwiftUI
import BackgroundTasks

@main
struct FuelPumpApp: App {

    @Environment(\.scenePhase) private var phase

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .background: addBackgroundTaskDataRefresh()
            default: break
            }
        }
        .backgroundTask(.appRefresh("dataRefresh")) {
            print("||DEBUG|| Background task: dataRefresh")
            let _ = DefaultGasStationRepository().fetchAllGasStations()
        }
    }
}

// MARK: - Background tasks
extension FuelPumpApp {

    func addBackgroundTaskDataRefresh() {
        cancelBackgroundTaskDataRefresh()
        let request = BGAppRefreshTaskRequest(identifier: "dataRefresh")
        request.earliestBeginDate = Calendar.current.date(byAdding: .hour, value: 6, to: Date())
        do {
            try BGTaskScheduler.shared.submit(request)
            print("||DEBUG|| addBackgroundTaskDataRefresh operation: Successfully configured.")
        } catch(let error) {
            print("||DEBUG|| addBackgroundTaskDataRefresh error operation: \(error.localizedDescription)")
        }
    }

    func cancelBackgroundTaskDataRefresh() {
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: "dataRefresh")
    }
}

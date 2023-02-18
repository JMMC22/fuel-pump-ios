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
        Text("GasStationList")
            .onAppear {
                Task {
                    await viewModel.getAllGasStation()
                }
            }
    }
}

//
//  ContentView.swift
//  FuelPump
//
//  Created by Jose Mari on 10/1/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        Group {
            content()
        }
        .task {
            viewModel.viewDidLoad()
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        if !viewModel.isLoading, viewModel.splashAnimationEnded {
            if viewModel.isLogged {
                MainView()
            } else {
                AppCoordinatorView(rootPage: .onboarding)
            }
        } else {
            SplashView(animationEnded: $viewModel.splashAnimationEnded)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

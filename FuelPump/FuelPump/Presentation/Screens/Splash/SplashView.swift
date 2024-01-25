//
//  SplashView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 4/7/23.
//

import SwiftUI

struct SplashView: View {

    @StateObject private var viewModel: SplashViewModel = SplashViewModel()
    @Binding var animationEnded: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.primaryGreen)
                .edgesIgnoringSafeArea(.all)
            Image("splash-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
        }
        .onAppear {
            viewModel.viewDidLoad()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                animationEnded = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(animationEnded: .constant(false))
    }
}

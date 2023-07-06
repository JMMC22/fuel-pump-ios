//
//  SplashView.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 4/7/23.
//

import SwiftUI

struct SplashView: View {

    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            if self.isActive {
                OnboardingView()
            } else {
                Rectangle()
                    .fill(Color.primary)
                    .edgesIgnoringSafeArea(.all)
                Image("splash-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

//
//  OnboardingFuelSelectorViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 23/8/23.
//

import Foundation
import SwiftUI
import Combine

final class OnboardingFuelSelectorViewModel: ObservableObject {

    @Published var fuelOptions: [SelectorOption]
    @Published var fuelSelectedOption: SelectorOption

    @Published var page: AppCoordinator.Page?

    private let updateUserFuelUseCase: UpdateUserFuelTypeUseCase
    private var cancellables = Set<AnyCancellable>()

    init(updateUserFuelUseCase: UpdateUserFuelTypeUseCase = DefaultUpdateUserFuelTypeUseCase(userRepository: DefaultUserRepository())) {
        self.fuelOptions = FuelType.allCases.map({ SelectorOption(key: $0.rawValue, value: $0.rawValue)})
        self.fuelSelectedOption = SelectorOption(key: FuelType.dieselA.rawValue, value: FuelType.dieselA.rawValue)
        self.updateUserFuelUseCase = updateUserFuelUseCase
    }

    func saveUserFuelSelection() {
        updateUserFuelUseCase
            .execute(FuelType(rawValue: fuelSelectedOption.key) ?? .dieselA)
            .sink(receiveCompletion: handleCompletion, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            navigateToMain()
        case .failure(let error):
            print("||ERROR|| saveUserFuelSelection: \(error.localizedDescription)")
        }
    }

    private func navigateToMain() {
        page = .main
    }
}

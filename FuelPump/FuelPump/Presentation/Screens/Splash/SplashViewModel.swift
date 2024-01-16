//
//  SplashViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 15/1/24.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {

    @Published var isActive: Bool = false
    @Published var isUser: Bool = false

    private let getUserUseCase: GetUserUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getUserUseCase: GetUserUseCase = DefaultGetUserUseCase(userRepository: DefaultUserRepository())) {
        self.getUserUseCase = getUserUseCase
    }

    func viewDidLoad() {
        getUser()
    }
}

// MARK: - Get User
extension SplashViewModel {
    private func getUser() {
        getUserUseCase.execute()
            .sink(receiveCompletion: handleCompletion, receiveValue: handleResponse)
            .store(in: &cancellables)
    }

    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            self.isActive = true
        case .failure(let error):
            print("Error: \(error)")
        }
    }

    private func handleResponse(user: User?) {
        if user != nil {
            self.isUser = true
        } else {
            self.isUser = false
        }
    }
}

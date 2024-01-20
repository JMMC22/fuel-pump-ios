//
//  ContentViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/1/24.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {

    @Published var splashAnimationEnded: Bool = false
    @Published var isLoading: Bool = true
    @Published var isLogged: Bool = false

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
extension ContentViewModel {
    private func getUser() {
        getUserUseCase.execute()
            .sink(receiveCompletion: handleCompletion, receiveValue: handleResponse)
            .store(in: &cancellables)
    }

    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            self.isLoading = false
        case .failure(let error):
            print("Error: \(error)")
        }
    }

    private func handleResponse(user: User?) {
        if user != nil {
            self.isLogged = true
        } else {
            self.isLogged = false
        }
    }
}

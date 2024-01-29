//
//  SplashViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 20/1/24.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {

    private let fetchAllGasStationsUseCase: FetchAllGasStationsUseCase

    private var cancellables = Set<AnyCancellable>()

    init(fetchAllGasStationsUseCase: FetchAllGasStationsUseCase = DefaultFetchAllGasStationsUseCase()) {
        self.fetchAllGasStationsUseCase = fetchAllGasStationsUseCase
    }

    func viewDidLoad() {
        fetchAll()
    }

    private func fetchAll() {
        fetchAllGasStationsUseCase.execute()
            .sink(receiveCompletion: handleCompletion, receiveValue: {})
            .store(in: &cancellables)
    }

    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("||DEBUG|| fetchAll operation: Successfully completed.")
        case .failure(let error):
            print("||ERROR|| fetchAll operation failed with error: \(error)")
        }
    }
}

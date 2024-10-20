//
//  CharacterListViewModel.swift
//  YassirTask
//
//  Created by Khalid on 20/10/2024.
//

import Foundation
import Combine

final class CharacterListViewModel: ObservableObject {
    @Published var characters: [CharacterListItem] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    var useCase: CharacterListUsecaseProtocol
    
    init(useCase: CharacterListUsecaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchCharacters(at page: Int) {
        isLoading = true
        useCase.fetchCharacters(at: page)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false // Ensure loading is stopped on completion
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] characterList in
                    self?.characters = characterList.characters ?? [] // Safely unwrap characters
                }
            )
            .store(in: &cancellables)
    }
}

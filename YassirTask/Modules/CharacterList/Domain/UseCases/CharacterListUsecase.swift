//
//  DriverPerformanceUsecase.swift
//  Saned
//
//  Created by Khalid on 03/09/2024.
//

import Foundation
import Combine

protocol CharacterListUsecaseProtocol {
    func fetchCharacters(at page: Int) -> AnyPublisher<CharacterList, NetworkError>
}

class CharacterListUsecase: CharacterListUsecaseProtocol {
    private let characterListRepository: CharacterListRepositoryProtocol
    
    init(characterListRepository: CharacterListRepositoryProtocol) {
        self.characterListRepository = characterListRepository
    }
    
    func fetchCharacters(at page: Int) -> AnyPublisher<CharacterList, NetworkError> {
        return characterListRepository.fetchCharacters(at: page)
    }
}


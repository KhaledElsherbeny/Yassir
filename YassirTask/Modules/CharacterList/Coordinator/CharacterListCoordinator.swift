//
//  CharacterListCoordinator.swift
//  YassirTask
//
//  Created by Khalid on 21/10/2024.
//

import UIKit

final class CharacterListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service = CharactersService()
        let repository = CharacterListRepository(charactersService: service)
        let useCase = CharacterListUsecase(characterListRepository: repository)
        let viewModel = CharacterListViewModel(useCase: useCase, coordinator: self)
        let characterListVC = CharacterListView(viewModel: viewModel)
        navigationController.pushViewController(characterListVC, animated: true)
    }
}

//
//  ViewController.swift
//  YassirTask
//
//  Created by Khalid on 13/10/2024.
//

import UIKit
import Combine

import UIKit
import Combine

class CharacterListView: UIViewController {
    
    @IBOutlet private(set) var tableView: UITableView!
    var viewModel: CharacterListViewModel!
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        let service = CharactersService()
        let repository = CharacterListRepository(charactersService: service)
        let useCase = CharacterListUsecase(characterListRepository: repository)
        viewModel = CharacterListViewModel(useCase: useCase)
        
        bindViewModel()
        
        // Optionally, fetch characters initially
        viewModel.fetchCharacters(at: 1) // or any page number you want to start with
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            CharacterItemTableViewCell.nib,
            forCellReuseIdentifier: CharacterItemTableViewCell.viewIdentifier
        )
    }

    private func bindViewModel() {
        // Bind characters array to update the table view
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        // Bind isLoading state to show/hide the loading spinner
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { isLoading in
                if isLoading {
                    LoadingView.show()
                } else {
                    LoadingView.hide()
                }
            }
            .store(in: &cancellables)
        
        // Bind errorMessage to show an alert if there is an error
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let message = errorMessage, !message.isEmpty else { return }
                self?.showErrorMessage(message: message)
            }
            .store(in: &cancellables)
    }

    private func showErrorMessage(message: String) {
        let alertController = AlertBuilder(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        .addAction(title: "Ok", style: .default, handler: nil)
        .build()

        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CharacterListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count // Return the number of characters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = CharacterItemTableViewCell.instance(tableView, indexPath: indexPath) else {
            return UITableViewCell()
        }
        let character = viewModel.characters[indexPath.row]
        cell.setup(with: character)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CharacterListView: UITableViewDelegate {
    // Implement UITableViewDelegate methods if needed
}

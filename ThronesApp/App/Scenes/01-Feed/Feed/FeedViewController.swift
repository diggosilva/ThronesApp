//
//  ViewController.swift
//  ThronesApp
//
//  Created by Diggo Silva on 15/10/25.
//

import UIKit
import Combine

class FeedViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let feedView = FeedView()
    private let viewModel: any FeedViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    private var shouldShowEmptyState = false
    
    init(viewModel: any FeedViewModelProtocol = FeedViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDataSourcesAndDelegates()
        handlesStates()
        viewModel.fetchCharacters()
    }
    
    private func setNavBar() {
        navigationItem.title = "Game Of Thrones"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search characters"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setDataSourcesAndDelegates() {
        feedView.collectionView.dataSource = self
        feedView.collectionView.delegate = self
    }
    
    private func handlesStates() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .loading: self?.showLoadingState()
                case .loaded: self?.showLoadedState()
                    self?.setNeedsUpdateContentUnavailableConfiguration()
                case .error: self?.showErrorState()
                }
            }.store(in: &cancellables)
    }
    
    private func showLoadingState() {
        feedView.spinner.startAnimating()
    }
    
    private func showLoadedState() {
        feedView.spinner.stopAnimating()
        feedView.collectionView.reloadData()
    }
    
    private func showErrorState() {
        showCustomAlert(title: "Ops!", message: "Algo deu errado. Tente novamente mais tarde.", buttonTitle: "Ok") {
            self.feedView.spinner.stopAnimating()
        }
    }
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        let isSearching = !(searchController.searchBar.text?.isEmpty ?? true)
        
        guard shouldShowEmptyState || isSearching else {
            contentUnavailableConfiguration = nil
            return
        }
        
        if viewModel.numberOfRows() == 0 {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "magnifyingglass")
            config.text = "Nada encontrado"
            
            let text = searchController.searchBar.text ?? ""
            
            if text.isEmpty {
                config.secondaryText = "Nenhum item disponível."
            } else {
                config.secondaryText = "Nenhum resultado para '\(text)'"
            }
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
}

extension FeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        viewModel.searchBarTextDidChange(searchText: text)
        setNeedsUpdateContentUnavailableConfiguration()
        feedView.collectionView.reloadData()
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        let char = viewModel.character(at: indexPath.item)
        cell.configure(char: char)
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let char = viewModel.character(at: indexPath.item)
        let viewModel = DetailsViewModel(char: char)
        let detailsVC = DetailsViewController(viewModel: viewModel)
        detailsVC.navigationItem.title = char.fullName
        detailsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

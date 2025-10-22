//
//  ViewController.swift
//  ThronesApp
//
//  Created by Diggo Silva on 15/10/25.
//

import UIKit
import Combine

class FeedViewController: UIViewController {

    private let feedView = FeedView()
    private let viewModel = FeedViewModel()
    private var cancellables = Set<AnyCancellable>()
    
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
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

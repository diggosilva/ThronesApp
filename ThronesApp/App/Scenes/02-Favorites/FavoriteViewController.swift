//
//  FavoriteViewController.swift
//  ThronesApp
//
//  Created by Diggo Silva on 28/10/25.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private let favoriteView = FavoriteView()
    private let viewModel: FavoritesViewModelProtocol
    
    init(viewModel: FavoritesViewModelProtocol = FavoriteViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setDelegate(self)
        viewModel.loadChars()
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Favoritos"
    }
    
    private func configureDelegatesAndDataSources() {
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        favoriteView.tableView.reloadData()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.numberOfRows() == 0 {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star.slash")
            config.text = "Você ainda não tem personagens favoritos."
            
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        let char = viewModel.cellForRow(at: indexPath.row)
        cell.configure(char: char)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeChar(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            viewModel.saveChars()
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let char = viewModel.cellForRow(at: indexPath.row)
        let viewModel = DetailsViewModel(char: char)
        let detailsVC = DetailsViewController(viewModel: viewModel)
        detailsVC.hidesBottomBarWhenPushed = true
        detailsVC.title = char.fullName
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func reloadTable() {
        favoriteView.tableView.reloadData()
    }
}

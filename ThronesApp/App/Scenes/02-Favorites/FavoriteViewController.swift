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
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Favoritos"
    }
    
    private func configureDelegatesAndDataSources() {
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        favoriteView.tableView.reloadData()
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
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func reloadTable() {
        favoriteView.tableView.reloadData()
    }
}

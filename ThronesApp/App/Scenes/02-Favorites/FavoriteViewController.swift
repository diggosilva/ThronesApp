//
//  FavoriteViewController.swift
//  ThronesApp
//
//  Created by Diggo Silva on 28/10/25.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private let favoriteView = FavoriteView()
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDelegatesAndDataSources()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Favoritos"
    }
    
    private func configureDelegatesAndDataSources() {
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "Linha \(indexPath.row + 1)"
        content.secondaryText = "Casa"
        content.image = UIImage(systemName: "star.fill")
        
        cell.contentConfiguration = content
        return cell
    }
}

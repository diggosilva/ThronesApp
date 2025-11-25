//
//  DetailsViewController.swift
//  ThronesApp
//
//  Created by Diggo Silva on 26/10/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let detailsView = DetailsView()
    private let viewModel: DetailsViewModelProtocol
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharacter()
        setBarButtonItem()
    }
    
    func setBarButtonItem() {
        let favoriteBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapFavorite))
        navigationItem.rightBarButtonItem = favoriteBarButton
    }
    
    @objc private func didTapFavorite() {
        print("Personagem Adicionado...")
        let char = viewModel.getCharacter()
        viewModel.addToFavorites(char: char) { result in
            print("Adicionou aos favoritos o personagem: \(char.fullName)")
        }
    }
    
    private func setupCharacter() {
        detailsView.configure(char: viewModel.getCharacter())
    }
}

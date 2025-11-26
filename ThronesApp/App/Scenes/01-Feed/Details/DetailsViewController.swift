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
        let char = self.viewModel.getCharacter()
        
        Task {
            do {
                try await viewModel.addToFavorites(char: char)
                showCustomAlert(title: "Salvo! ✅", message: "Personagem adicionado", buttonTitle: "Ok")
            } catch DSError.charAlreadyExists {
                showCustomAlert(title: "Ops! ⚠️", message: "\(char.fullName) já está salvo", buttonTitle: "Ok")
            } catch {
                showCustomAlert(title: "Erro! ❌", message: "Não foi possível salvar", buttonTitle: "Ok")
            }
        }
    }
    
    private func setupCharacter() {
        detailsView.configure(char: viewModel.getCharacter())
    }
}

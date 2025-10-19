//
//  ViewController.swift
//  ThronesApp
//
//  Created by Diggo Silva on 15/10/25.
//

import UIKit

class FeedViewController: UIViewController {

    private let feedView = FeedView()
    
    override func loadView() {
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDataSourcesAndDelegates()
    }
    
    private func setNavBar() {
        navigationItem.title = "Game Of Thrones"
    }
    
    private func setDataSourcesAndDelegates() {
        feedView.collectionView.dataSource = self
        feedView.collectionView.delegate = self
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        cell.configure()
        return cell
    }
}

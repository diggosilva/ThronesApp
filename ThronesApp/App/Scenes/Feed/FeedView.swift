//
//  FeedView.swift
//  ThronesApp
//
//  Created by Diggo Silva on 17/10/25.
//

import UIKit

class FeedView: UIView {
    
    private let layout = UICollectionViewFlowLayout()
    
    lazy var collectionView: UICollectionView = {
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        cv.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubview(collectionView)
        backgroundColor = .systemBackground
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard layout.itemSize == .zero else { return }
        
        let totalSpacing: CGFloat = layout.minimumInteritemSpacing * 4
        let availableWidth = bounds.width - totalSpacing
        let cellWidth = availableWidth / 3
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.5)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

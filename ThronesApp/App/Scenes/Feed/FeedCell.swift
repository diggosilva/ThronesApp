//
//  FeedCell.swift
//  ThronesApp
//
//  Created by Diggo Silva on 18/10/25.
//

import UIKit
import SDWebImage

final class FeedCell: UICollectionViewCell {
    
    static let identifier = "FeedCell"
    
    lazy var charImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "star")
        return iv
    }()
    
    lazy var charName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .systemBackground
        lbl.font = .preferredFont(forTextStyle: .footnote)
        lbl.textAlignment = .center
        lbl.text = "Name Last Name"
        lbl.backgroundColor = .systemRed
        return lbl
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
        addSubview(charImageView)
        addSubview(charName)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            charImageView.topAnchor.constraint(equalTo: topAnchor),
            charImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            charImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            charImageView.bottomAnchor.constraint(equalTo: charName.topAnchor),
            
            charName.heightAnchor.constraint(equalToConstant: 24),
            charName.leadingAnchor.constraint(equalTo: leadingAnchor),
            charName.trailingAnchor.constraint(equalTo: trailingAnchor),
            charName.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configure(char: Char) {
        guard let url = URL(string: char.imageUrl) else { return }
        
        charImageView.sd_setImage(with: url)
        charName.text = char.firstName
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
}

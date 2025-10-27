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
        iv.image = UIImage(systemName: "star")
        iv.clipsToBounds = true
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        iv.layer.cornerRadius = 8
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
        lbl.clipsToBounds = true
        lbl.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        lbl.layer.cornerRadius = 8
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        applyShadow(view: self)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        contentView.addSubview(charImageView)
        contentView.addSubview(charName)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            charImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            charImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            charImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            charImageView.bottomAnchor.constraint(equalTo: charName.topAnchor),
            
            charName.heightAnchor.constraint(equalToConstant: 24),
            charName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            charName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            charName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(char: Char) {
        guard let url = URL(string: char.imageUrl) else { return }
        
        charImageView.sd_setImage(with: url)
        charName.text = char.firstName
    }
    
    func applyShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 4.0
        view.layer.masksToBounds = false
    }
}

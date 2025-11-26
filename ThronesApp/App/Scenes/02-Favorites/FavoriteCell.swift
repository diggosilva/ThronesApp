//
//  FavoriteCell.swift
//  ThronesApp
//
//  Created by Diggo Silva on 25/11/25.
//

import UIKit
import SDWebImage

final class FavoriteCell: UITableViewCell {
    
    static let identifier: String = "FavoriteCell"
    
    lazy var charImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    lazy var houseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var HStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [fullNameLabel, houseLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        contentView.addSubview(charImageView)
        contentView.addSubview(HStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            charImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            charImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            charImageView.heightAnchor.constraint(equalToConstant: 50),
            charImageView.widthAnchor.constraint(equalToConstant: 50),
            
            HStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            HStack.leadingAnchor.constraint(equalTo: charImageView.trailingAnchor, constant: 16),
            HStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            HStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(char: Char) {
        guard let url = URL(string: char.imageUrl) else { return }
        
        charImageView.sd_setImage(with: url)
        fullNameLabel.text = char.fullName
        houseLabel.text = char.family
    }
}

//
//  CollectionViewCell.swift
//  Internship
//
//  Created by Лера Тарасенко on 12.01.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
 
    static let reuseId = "CollectionViewCell"
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Condensed Regular", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let isSelectedImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkmark")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = #colorLiteral(red: 0.972464025, green: 0.9726033807, blue: 0.9724336267, alpha: 1)
        contentView.layer.cornerRadius = 5
        
        addSubview(icon)
        icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        icon.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 52).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 52).isActive = true

        addSubview(isSelectedImage)
        isSelectedImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        isSelectedImage.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        isSelectedImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        isSelectedImage.heightAnchor.constraint(equalToConstant: 20).isActive = true

        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)

        stackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: isSelectedImage.leadingAnchor, constant: -20).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool{
        didSet{
            if self.isSelected && isSelectedImage.isHidden{
                isSelectedImage.isHidden = false
            } else if !isSelectedImage.isHidden{
                isSelectedImage.isHidden = true
            }
        }
    }
}

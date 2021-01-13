//
//  CollectionViewCell.swift
//  Internship
//
//  Created by Лера Тарасенко on 12.01.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isSelectedImage: UIImageView!
    
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

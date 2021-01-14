//
//  collectionView.swift
//  Internship
//
//  Created by Лера Тарасенко on 13.01.2021.
//

import UIKit

class CollectionView: UICollectionView {
    var vc: ViewController!
    
    var ads: [Ad] = []
    var selectedAdTitle = ""
 
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: Ads) {
        self.ads = model.list.filter{$0.isSelected}
    }
      
}

// MARK: UICollectionViewDataSource
extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ad = ads[indexPath.row]
        
        let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        
        cell.isSelectedImage.isHidden = true
        
        NetworkManager.downloadImage(url: ad.icon.resolution) {icon in
            cell.icon.image = icon
        }
        
        cell.titleLabel.text = ad.title
        cell.descriptionLabel.text = ad.description ?? ""
        cell.priceLabel.text = ad.price
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell

        let ad = ads[indexPath.row]

        self.vc.selectedAdTitle = !cell.isSelectedImage.isHidden ? ad.title : ""
        
        vc.changeTitleButton(isNotHidden: !cell.isSelectedImage.isHidden)
    }
}


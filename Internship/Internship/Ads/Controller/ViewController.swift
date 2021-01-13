//
//  ViewController.swift
//  Internship
//
//  Created by Лера Тарасенко on 12.01.2021.
//

import UIKit

private let path = Bundle.main.path(forResource: "result", ofType: "json")
private let reuseIdentifier = "Cell"

class ViewController: UIViewController {
    
    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var alert: UIAlertController!
    
    var ads: [Ad] = []
    var selectedAdTitle = ""
    var actionTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataProvider.fetchData(path: path ?? ""){ (ads) in
            self.ads = ads.result.list
            self.headLabel.text = ads.result.title
            self.actionTitle = ads.result.actionTitle
        }
    }
    
    @IBAction func selectButtonAction(_ sender: UIButton) {
        var title = ""
        var message = ""
        var actionTitle = ""
        
        if selectedAdTitle.isEmpty{
            title = "Ошибка"
            message = "Вы не выбрали услугу"
            actionTitle = "Готово"
        } else {
            title = "Вы выбрали"
            message = selectedAdTitle
            actionTitle = self.actionTitle
        }
        
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: actionTitle, style: .default)
        
        alert.addAction(doneAction)
        present(alert, animated: true)
        
    }
}

// MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let ad = ads[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.isSelectedImage.isHidden = true
        
        if ad.isSelected {
            NetworkManager.downloadImage(url: ad.icon.resolution) {icon in
                cell.icon.image = icon
            }
            
            cell.titleLabel.text = ad.title
            cell.descriptionLabel.text = ad.description ?? ""
            cell.priceLabel.text = ad.price
        } else {
            cell.contentView.backgroundColor = .none
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        let ad = ads[indexPath.row]
        
        self.selectedAdTitle = !cell.isSelectedImage.isHidden ? ad.title : ""
    }
}

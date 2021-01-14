//
//  ViewController.swift
//  Internship
//
//  Created by Лера Тарасенко on 12.01.2021.
//

import UIKit

private let path = Bundle.main.path(forResource: "result", ofType: "json")

class ViewController: UIViewController {
    private var model: Ads?
    
    var selectedAdTitle = ""
    var actionTitle = ""
    var selectedActionTitle = ""
    
    private var collectionView = CollectionView()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CloseIconTemplate"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var headLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.3332491815, green: 0.6762878299, blue: 0.9460956454, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private var alert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataProvider.fetchData(path: path ?? ""){ (ads) in
            self.model = ads.result
            self.headLabel.text = ads.result.title
            self.actionTitle = ads.result.actionTitle
            self.selectedActionTitle = ads.result.selectedActionTitle
        }
        
        view.addSubview(exitButton)
        exitButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(headLabel)
        headLabel.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 50).isActive = true
        headLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18).isActive = true
        headLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 18).isActive = true
        
        selectButton.setTitle(actionTitle, for: .normal)
        view.addSubview(selectButton)
        
        let buttonTrailingConstraint = NSLayoutConstraint(item: selectButton,
                                                          attribute: NSLayoutConstraint.Attribute.trailing,
                                                          relatedBy: NSLayoutConstraint.Relation.equal,
                                                          toItem: view.safeAreaLayoutGuide,
                                                          attribute: NSLayoutConstraint.Attribute.trailing,
                                                          multiplier: 1,
                                                          constant: -20)
        let buttonBottomConstraint = NSLayoutConstraint(item: selectButton,
                                                       attribute: NSLayoutConstraint.Attribute.bottom,
                                                       relatedBy: NSLayoutConstraint.Relation.equal,
                                                       toItem: view.safeAreaLayoutGuide,
                                                       attribute: NSLayoutConstraint.Attribute.bottom,
                                                       multiplier: 1,
                                                       constant: -10)
        
        let buttonLeadingConstraint = NSLayoutConstraint(item: selectButton,
                                                         attribute: NSLayoutConstraint.Attribute.leading,
                                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                                         toItem: view.safeAreaLayoutGuide,
                                                         attribute: NSLayoutConstraint.Attribute.leading,
                                                         multiplier: 1,
                                                         constant: 20)
        
        let buttonHeightConstraint = NSLayoutConstraint(item: selectButton,
                                                        attribute: NSLayoutConstraint.Attribute.height,
                                                        relatedBy: NSLayoutConstraint.Relation.equal,
                                                        toItem: nil,
                                                        attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                        multiplier: 1,
                                                        constant: 50)
        view.addConstraints([buttonTrailingConstraint, buttonBottomConstraint, buttonLeadingConstraint, buttonHeightConstraint])
        
        collectionView.vc = self
        collectionView.backgroundColor = .none

        view.addSubview(collectionView)
        
        collectionView.set(model: model!)
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        collectionView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 45).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -30).isActive = true
        
        
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        var title = ""
        var message = ""
        var actionTitle = ""
        
        if selectedAdTitle.isEmpty{
            title = "Вы не выбрали услугу"
            actionTitle = self.actionTitle
        } else {
            title = "Вы выбрали"
            message = selectedAdTitle
            actionTitle = selectedActionTitle
        }
        
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: actionTitle, style: .default)
        
        alert.addAction(doneAction)
        present(alert, animated: true)
    }
    
    func changeTitleButton(isNotHidden: Bool){
        let title = isNotHidden ? selectedActionTitle : actionTitle
        selectButton.setTitle(title, for: .normal)
    }
}


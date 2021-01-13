//
//  NetworkManager.swift
//  Internship
//
//  Created by Лера Тарасенко on 12.01.2021.
//

import UIKit

class NetworkManager {
    
    static func downloadImage(url: String, complition: @escaping (_ image: UIImage) -> () ){
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    complition(image)
                }
            }
        } .resume()
    }
}

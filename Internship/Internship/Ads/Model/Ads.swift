//
//  Model.swift
//  Internship
//
//  Created by Лера Тарасенко on 12.01.2021.
//

import Foundation

struct MainModel: Codable {
    let status: String
    let result: Ads
}

struct Ads: Codable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [Ad]
}

struct Ad: Codable {
    let id: String
    let title: String
    let description: String?
    let icon: Icon
    let price: String
    var isSelected: Bool
}

struct Icon: Codable {
    let resolution: String
    
    enum CodingKeys: String, CodingKey{ 
        case resolution = "52x52"
    }
}

//
//  DataProvider.swift
//  Internship
//
//  Created by Лера Тарасенко on 13.01.2021.
//

import Foundation

class DataProvider {
    static func fetchData(path: String, complition: @escaping (_ model: MainModel) -> ()) {
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path ), options: .mappedIfSafe)
            
            let decoder = JSONDecoder()
            
            let model = try decoder.decode(MainModel.self, from: data)
            
            complition(model)
        } catch let error {
            print("Error serialization json:", error.localizedDescription)
        }
    }
}

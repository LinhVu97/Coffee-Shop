//
//  ParseJson.swift
//  CoffeHouse
//
//  Created by Linh Vu on 12/11/24.
//

import Foundation

class ParseJson {
    static let shared = ParseJson()
    
    func parseData<T: Codable>(_ type: T.Type, fileName: String) -> [T]? {
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let receivedData = try JSONDecoder().decode([T].self, from: data)
            return receivedData
        } catch {
            print(error)
            return nil
        }
    }
}

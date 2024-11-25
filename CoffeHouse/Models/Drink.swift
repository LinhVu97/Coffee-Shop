//
//  Drink.swift
//  CoffeHouse
//
//  Created by Linh Vu on 13/11/24.
//

import Foundation

struct Drink: Codable, Equatable {
    let id: String
    let image: String
    let name: String
    var price: Float
    let sizes: [String]
    let rating: Float
    var quantity: Int = 1
    let type: [String]
}

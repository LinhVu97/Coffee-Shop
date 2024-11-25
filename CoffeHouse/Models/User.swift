//
//  User.swift
//  CoffeHouse
//
//  Created by Linh Vu on 12/11/24.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var username: String
    var password: String
    var isAdmin: Bool
}

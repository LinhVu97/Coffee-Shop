//
//  MainTab.swift
//  CoffeHouse
//
//  Created by Linh Vu on 11/11/24.
//

import Foundation
import UIKit

enum MainTab: String {
    case home
    case favourite
    case cart
    case profile
    
    func image(isSelected: Bool) -> UIImage? {
        return UIImage(named: "ic_\(self.rawValue)_\(isSelected ? "selected" : "unselected")")
    }
    
    func name() -> String? {
        return self.rawValue.capitalized
    }
}

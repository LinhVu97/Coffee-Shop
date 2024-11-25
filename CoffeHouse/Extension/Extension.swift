//
//  Extension.swift
//  CoffeHouse
//
//  Created by Linh Vu on 8/11/24.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        left + width
    }
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        top + height
    }
    
    func setGradientColor(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 2, y: 0)
        
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//
//  CustomButton.swift
//  CoffeHouse
//
//  Created by Linh Vu on 13/11/24.
//

import UIKit

class CustomButton: UIButton {
    var sizeTitleButton: CGFloat
    var widthButton: CGFloat
    var heightButton: CGFloat
    
    init(sizeTitleButton: CGFloat, widthButton: CGFloat, heightButton: CGFloat) {
        self.sizeTitleButton = sizeTitleButton
        self.widthButton = widthButton
        self.heightButton = heightButton
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        clipsToBounds = true
        configureButton()
    }
    
    private func configureButton() {
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.hex846046.cgColor
        setTitleColor(.hex846046, for: .normal)
        titleLabel?.font = .systemFont(ofSize: sizeTitleButton, weight: .regular)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: heightButton),
            widthAnchor.constraint(equalToConstant: widthButton)
            
        ])
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .hex846046 : .clear
            setTitleColor(isSelected ? .white : .hex846046, for: .normal)
        }
    }
}

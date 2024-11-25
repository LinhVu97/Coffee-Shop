//
//  AddToCartButton.swift
//  CoffeHouse
//
//  Created by Linh Vu on 15/11/24.
//

import UIKit

class AddToCartButton: UIButton {
    
    private lazy var addToCartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add to Cart"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .hexF8F7FA
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        layer.cornerRadius = 30
        
        addSubview(addToCartLabel)
        addSubview(seperatorView)
        addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 75),
            
            addToCartLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            addToCartLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            addToCartLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            
            seperatorView.centerYAnchor.constraint(equalTo: addToCartLabel.centerYAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: addToCartLabel.trailingAnchor, constant: 55),
            seperatorView.widthAnchor.constraint(equalToConstant: 1),
            seperatorView.heightAnchor.constraint(equalToConstant: 24),
            
            priceLabel.centerYAnchor.constraint(equalTo: addToCartLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55)
        ])
    }
    
    func configure(price: String) {
        priceLabel.text = price
    }
}

//
//  DrinkNameView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 14/11/24.
//

import UIKit

class DrinkNameView: UIView {
    var drink: Drink? {
        didSet {
            configure()
        }
    }
    
    private lazy var drinkName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var ratingLabelContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 15
        container.layer.masksToBounds = true
        container.backgroundColor = UIColor.hex846046
        return container
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_star")
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = . white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black.withAlphaComponent(0.3)
        clipsToBounds = true
        
        addSubview(drinkName)
        addSubview(ratingLabelContainer)
        ratingLabel.addSubview(starImageView)
        ratingLabelContainer.addSubview(ratingLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            drinkName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            drinkName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            drinkName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            ratingLabelContainer.centerYAnchor.constraint(equalTo: drinkName.centerYAnchor),
            ratingLabelContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            starImageView.topAnchor.constraint(equalTo: ratingLabelContainer.topAnchor, constant: 8),
            starImageView.leadingAnchor.constraint(equalTo: ratingLabelContainer.leadingAnchor, constant: 8),
            starImageView.bottomAnchor.constraint(equalTo: ratingLabelContainer.bottomAnchor, constant: -8),
            starImageView.widthAnchor.constraint(equalToConstant: 15),
            starImageView.heightAnchor.constraint(equalToConstant: 15),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 3),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingLabelContainer.trailingAnchor, constant: -8),
            ratingLabel.topAnchor.constraint(equalTo: ratingLabelContainer.topAnchor, constant: 8),
            ratingLabel.bottomAnchor.constraint(equalTo: ratingLabelContainer.bottomAnchor, constant: -8)
        ])
    }
    
    private func configure() {
        guard let drink = drink else { return }
        drinkName.text = drink.name
        ratingLabel.text = "\(drink.rating)"
    }
}

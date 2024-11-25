//
//  DrinkDetailViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 13/11/24.
//

import UIKit

class DrinkDetailViewController: UIViewController {
    var drink: Drink?
    
    private lazy var drinkNameView = DrinkNameView()
    private lazy var productDetailView = ProductDetailView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_back_button"), for: .normal)
        return button
    }()
    
    private lazy var drinkDetailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        configure()
    }

    private func setupView() {
        navigationItem.hidesBackButton = true
        
        view.addSubview(drinkDetailImage)
        view.addSubview(backButton)
        view.addSubview(drinkNameView)
        view.addSubview(productDetailView)
        
        drinkNameView.translatesAutoresizingMaskIntoConstraints = false
        productDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.addTarget(self, action: #selector(didBack), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),
            
            drinkDetailImage.topAnchor.constraint(equalTo: view.topAnchor),
            drinkDetailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drinkDetailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drinkDetailImage.heightAnchor.constraint(equalToConstant: view.frame.height*0.3),
            
            drinkNameView.bottomAnchor.constraint(equalTo: drinkDetailImage.bottomAnchor, constant: 22),
            drinkNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            drinkNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            drinkNameView.heightAnchor.constraint(equalToConstant: view.height*0.12),
            
            productDetailView.topAnchor.constraint(equalTo: drinkDetailImage.bottomAnchor, constant: -3),
            productDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func configure() {
        guard let drink = drink else { return }
        
        drinkDetailImage.image = UIImage(named: drink.image)
        drinkNameView.drink = drink
        productDetailView.drink = drink
    }
    
    @objc private func didBack() {
        navigationController?.popViewController(animated: true)
    }
}

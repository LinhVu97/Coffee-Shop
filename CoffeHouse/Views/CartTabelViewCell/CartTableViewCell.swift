//
//  CartTableViewCell.swift
//  CoffeHouse
//
//  Created by Linh Vu on 21/11/24.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    lazy var identifier = "CartTableViewCell"
    
    var cart: Drink!
    
    private lazy var cartImageView: UIImageView = {
        lazy var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_drink_cappuccino")
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        lazy var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        return view
    }()
    
    private lazy var cartName: UILabel = {
        lazy var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tuna Salad"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var cartPrice: UILabel = {
        lazy var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "14.22$"
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        lazy var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_star_no_color")
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        lazy var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black.withAlphaComponent(0.3)
        label.text = "4.5"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        lazy var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        lazy var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_minus_black"), for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        lazy var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_plus_black"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstrainst()
    }

    
    private func setupView() {
        clipsToBounds = true
        selectionStyle = .none
        addSubview(containerView)
        
        containerView.addSubview(cartImageView)
        containerView.addSubview(cartName)
        containerView.addSubview(cartPrice)
        containerView.addSubview(starImageView)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(quantityLabel)
        containerView.addSubview(minusButton)
        containerView.addSubview(plusButton)
        
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstrainst() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            cartImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            cartImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cartImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            
            cartName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            cartName.leadingAnchor.constraint(equalTo: cartImageView.trailingAnchor, constant: 10),
            
            cartPrice.topAnchor.constraint(equalTo: cartName.bottomAnchor),
            cartPrice.leadingAnchor.constraint(equalTo: cartImageView.trailingAnchor, constant: 12),
            
            ratingLabel.centerYAnchor.constraint(equalTo: cartName.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            starImageView.centerYAnchor.constraint(equalTo: cartName.centerYAnchor),
            starImageView.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -5),
            
            plusButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            plusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            quantityLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -5),
            
            minusButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -5),
        ])
    }
    
    @objc private func minusButtonTapped() {
        guard var cart = cart else { return }
        var number = Int(quantityLabel.text ?? "0") ?? 0
        
        if number > 1 {
            number -= 1
            quantityLabel.text = "\(number)"
            cart.quantity = number
            NotificationCenter.default.post(name: Notification.Name("UpdateQuantity"),
                                            object: nil,
                                            userInfo: ["cart": cart])
        } else if number == 1 {
            
            NotificationCenter.default.post(name: Notification.Name("RemoveFromCart"),
                                            object: nil, userInfo: ["cart" : cart])
        }
    }
    
    @objc private func plusButtonTapped() {
        guard var cart = cart else { return }
        var number = Int(quantityLabel.text ?? "0") ?? 0
        
        number += 1
        quantityLabel.text = "\(number)"
        cart.quantity = number
        
        NotificationCenter.default.post(name: Notification.Name("UpdateQuantity"),
                                        object: nil,
                                        userInfo: ["cart": cart])
        
    }
    
    func configure(cart: Drink) {
        self.cart = cart
        cartImageView.image = UIImage(named: "\(cart.image)")
        cartName.text = cart.name
        cartPrice.text = "\(cart.price)$"
        ratingLabel.text = "\(cart.rating)"
        quantityLabel.text = "\(cart.quantity)"
    }
}

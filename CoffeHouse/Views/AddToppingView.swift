//
//  AddToppingView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 15/11/24.
//

import UIKit

class AddToppingView: UIView {
    var toppings: [String] = ["Caramel", "Banana", "Chocolate", "Strawbery"]

    private var totalPrice: Double = 0.0
    private let toppingPrice: Double = 1.0

    private lazy var addToCartButton = AddToCartButton()

    private lazy var addToppingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add Topping(1$)"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private lazy var toppingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setConstrainst()
        setupToppings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        clipsToBounds = true

        addSubview(addToppingLabel)
        addSubview(toppingsStackView)
        addSubview(addToCartButton)
    }

    private func setConstrainst() {
        NSLayoutConstraint.activate([
            addToppingLabel.topAnchor.constraint(equalTo: topAnchor),
            addToppingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            addToppingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            toppingsStackView.topAnchor.constraint(
                equalTo: addToppingLabel.bottomAnchor, constant: 15),
            toppingsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            toppingsStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor),

            addToCartButton.topAnchor.constraint(
                equalTo: toppingsStackView.bottomAnchor, constant: 30),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupToppings() {
        for topping in toppings {
            let toppingView = ChooseToppingView(toppingName: topping)
            toppingView.chooseToppingDelegate = self
            toppingsStackView.addArrangedSubview(toppingView)
        }
    }

    func configure(price: String) {
        if let initialPrice = Double(price.replacingOccurrences(of: "$", with: "")) {
            totalPrice = initialPrice
        }
        
        addToCartButton.configure(price: price)
    }

    private func updatePrice() {
        let priceString = "\(totalPrice)$"
        addToCartButton.configure(price: priceString)
    }
}

extension AddToppingView: ChooseToppingViewDelegate {
    func didTapPlusButton() {
        totalPrice += toppingPrice  // Add price for a topping
        updatePrice()  // Update the price on the button
    }

    func didTapMinusButton() {
        if totalPrice > 0 {
            totalPrice -= toppingPrice  // Remove price for a topping
            updatePrice()  // Update the price on the button
        }
    }
}

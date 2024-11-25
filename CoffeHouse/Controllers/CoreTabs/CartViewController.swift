//
//  CartViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 8/11/24.
//

import UIKit

class CartViewController: UIViewController {
    var carts: [Drink] = []
    var cartItemCount = 0
    private lazy var cartTableViewCell = CartTableViewCell()
    
    private lazy var cartLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_cart_logo")
        return imageView
    }()
    
    private lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Order:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartTableViewCell.self,
                           forCellReuseIdentifier: cartTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Total: $0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var goToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_cart_button"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupConstraints()
        setupNotificationCenter()
        updateBadgeTabbar()
    }
    
    private func setupView() {
        view.addSubview(cartLogo)
        view.addSubview(cartLabel)
        view.addSubview(cartTableView)
        view.addSubview(priceLabel)
        view.addSubview(goToCartButton)
        
        goToCartButton.addTarget(self, action: #selector(didMoveToPayment), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cartLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cartLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            cartLogo.widthAnchor.constraint(equalToConstant: 40),
            cartLogo.heightAnchor.constraint(equalToConstant: 40),
            
            cartLabel.topAnchor.constraint(equalTo: cartLogo.topAnchor, constant: 50),
            cartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cartLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            cartTableView.topAnchor.constraint(equalTo: cartLabel.bottomAnchor, constant: 30),
            cartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            cartTableView.heightAnchor.constraint(equalToConstant: 300),
            
            priceLabel.topAnchor.constraint(equalTo: cartTableView.bottomAnchor, constant: 30),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            goToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            goToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            goToCartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
        ])
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAddToCart(_:)),
                                               name: Notification.Name("AddToCart"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didRemoveToCart(_:)),
                                               name: Notification.Name("RemoveFromCart"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didUpdateQuantity(_:)),
                                               name: Notification.Name("UpdateQuantity"),
                                               object: nil)
    }
    
    private func updatePrice() {
        var totalPrice: Float = 0
        
        if carts.count == 0 {
            priceLabel.text = "Total: $0"
        } else if carts.count > 0 {
            for cart in carts {
                totalPrice += cart.price * Float(cart.quantity)
                priceLabel.text = "Total: $\(totalPrice)"
            }
        }
    }
    
    @objc private func didMoveToPayment() {
        let paymentVC = PaymentViewController()
        paymentVC.modalPresentationStyle = .fullScreen
        present(paymentVC, animated: true)
    }
    
    @objc private func didAddToCart(_ notification: Notification) {
        if let cart = notification.userInfo?["cart"] as? Drink {
            if let existingIndex = carts.firstIndex(where: { $0.name == cart.name}) {
                carts[existingIndex].quantity += 1
            } else {
                carts.append(cart)
            }
            cartTableView.reloadData()
            updateBadgeTabbar()
            updatePrice()
        }
    }
    
    @objc private func didRemoveToCart(_ notification: Notification) {
        if let cart = notification.userInfo?["cart"] as? Drink {
            if let index = carts.firstIndex(where: { $0.id == cart.id }) {
                carts.remove(at: index)
                cartTableView.reloadData()
                updateBadgeTabbar()
                updatePrice()
            }
        }
    }
    
    @objc private func didUpdateQuantity(_ notification: Notification) {
        if let cart = notification.userInfo?["cart"] as? Drink {
            if let index = carts.firstIndex(where: { $0.id == cart.id }) {
                carts[index].quantity = cart.quantity
                cartTableView.reloadData()
                updateBadgeTabbar()
                updatePrice()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateBadgeTabbar() {
        cartItemCount = carts.count
        
        if let tabBarController = self.tabBarController,
           let cartTabbarItem = tabBarController.tabBar.items?[2] {
            cartTabbarItem.badgeValue = cartItemCount > 0 ? "\(cartItemCount)" : nil
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: cartTableViewCell.identifier,
                                                     for: indexPath) as! CartTableViewCell
        let cart = carts[indexPath.row]
        cell.configure(cart: cart)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cartTableView.deselectRow(at: indexPath, animated: true)
    }
}

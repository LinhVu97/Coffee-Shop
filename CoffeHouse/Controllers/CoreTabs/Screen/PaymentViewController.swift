//
//  PaymentViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 21/11/24.
//

import UIKit

class PaymentViewController: UIViewController {
    
    private lazy var paymentMethodView = PaymentMethodView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_back_button_black"), for: .normal)
        return button
    }()
    
    private lazy var paymentLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Order:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var paymentTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_location")
        return imageView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ukraine, Ivano-Frankivsk, Konovaltsya 132"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Total: $0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var createOrderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_create_order_button"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupContrainst()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(paymentLabel)
        view.addSubview(paymentTableView)
        view.addSubview(locationImage)
        view.addSubview(locationLabel)
        view.addSubview(paymentMethodView)
        view.addSubview(priceLabel)
        view.addSubview(createOrderButton)
        
        paymentMethodView.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
    
    private func setupContrainst() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),
            
            paymentLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 36),
            paymentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            paymentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            paymentTableView.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 30),
            paymentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            paymentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            paymentTableView.heightAnchor.constraint(equalToConstant: 200),
            
            locationImage.topAnchor.constraint(equalTo: paymentTableView.bottomAnchor, constant: 30),
            locationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 10),
            
            paymentMethodView.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 30),
            paymentMethodView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            paymentMethodView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            paymentMethodView.heightAnchor.constraint(equalToConstant: 200),
            
            priceLabel.topAnchor.constraint(equalTo: paymentMethodView.bottomAnchor, constant: 30),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            createOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            createOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            createOrderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didTapBack() {
        dismiss(animated: true)
    }
}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Payment"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paymentTableView.deselectRow(at: indexPath, animated: true)
    }
}

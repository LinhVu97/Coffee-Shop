//
//  PaymentMethodView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 22/11/24.
//

import UIKit

enum PaymentMethod: String {
    case applePay = "ApplePay"
    case visaPay = "Visa/MasterCard"
    case cashPay = "Cash"
    
    func image() -> UIImage? {
        return UIImage(named: "ic_\(self)")
    }
    
    func name() -> String {
        return self.rawValue
    }
}

class PaymentMethodView: UIView {
    
    private let methodTableViewCell = MethodTableViewCell()
    
    private let methods: [PaymentMethod] = [
        .applePay,
        .visaPay,
        .cashPay
    ]
    
    private lazy var paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Payment Method:"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .hexD9D9D9
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexE3E3E3.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelectedView))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var imageMethod: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_applePay")
        return imageView
    }()
    
    private lazy var nameMethod: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ApplePay"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var dropdownImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_dropdown_button")
        return imageView
    }()
    
    private lazy var methodTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MethodTableViewCell.self, forCellReuseIdentifier: methodTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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
        addSubview(paymentMethodLabel)
        addSubview(selectedView)
        addSubview(methodTableView)
        
        selectedView.addSubview(imageMethod)
        selectedView.addSubview(nameMethod)
        selectedView.addSubview(dropdownImage)
        
        methodTableView.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentMethodLabel.topAnchor.constraint(equalTo: topAnchor),
            paymentMethodLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            paymentMethodLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            selectedView.topAnchor.constraint(equalTo: paymentMethodLabel.bottomAnchor, constant: 10),
            selectedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedView.heightAnchor.constraint(equalToConstant: 50),
            
            imageMethod.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor),
            imageMethod.leadingAnchor.constraint(equalTo: selectedView.leadingAnchor, constant: 10),
            imageMethod.widthAnchor.constraint(equalToConstant: 18),
            imageMethod.heightAnchor.constraint(equalToConstant: 18),
            
            nameMethod.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor),
            nameMethod.leadingAnchor.constraint(equalTo: imageMethod.trailingAnchor, constant: 10),
            
            dropdownImage.centerYAnchor.constraint(equalTo: selectedView.centerYAnchor),
            dropdownImage.trailingAnchor.constraint(equalTo: selectedView.trailingAnchor, constant: -30),
            
            methodTableView.topAnchor.constraint(equalTo: paymentMethodLabel.bottomAnchor, constant: 10),
            methodTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            methodTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            methodTableView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    @objc private func didTapSelectedView() {
        methodTableView.isHidden = false
        selectedView.isHidden = true
    }
}

extension PaymentMethodView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = methodTableView.dequeueReusableCell(withIdentifier: methodTableViewCell.identifier,
                                                       for: indexPath) as! MethodTableViewCell
        let method = methods[indexPath.row]
        cell.config(image: method.image() ?? UIImage(),
                    name: method.name())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        methodTableView.deselectRow(at: indexPath, animated: true)
        
        selectedView.isHidden = false
        methodTableView.isHidden = true
        
        let method = methods[indexPath.row]
        imageMethod.image = method.image()
        nameMethod.text = method.name()
    }
}

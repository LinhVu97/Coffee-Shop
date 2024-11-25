//
//  ListFarvouriteViewTableViewCell.swift
//  CoffeHouse
//
//  Created by Linh Vu on 18/11/24.
//

import UIKit

class ListFarvouriteViewTableViewCell: UITableViewCell {
    let identifier = "ListFarvouriteViewTableViewCell"
    
    private lazy var farvouriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_drink_cappuccino")
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        return view
    }()
    
    private lazy var farvouriteName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tuna Salad"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var farvouritePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "14.22$"
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private lazy var heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_heart_color")
        return imageView
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_star_no_color")
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black.withAlphaComponent(0.3)
        label.text = "4.5"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_minus_black"), for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
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
        addSubview(containerView)
        
        containerView.addSubview(farvouriteImageView)
        containerView.addSubview(farvouriteName)
        containerView.addSubview(farvouritePrice)
        containerView.addSubview(heartImage)
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
            
            farvouriteImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            farvouriteImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            farvouriteImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            
            farvouriteName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            farvouriteName.leadingAnchor.constraint(equalTo: farvouriteImageView.trailingAnchor, constant: 10),
            
            farvouritePrice.topAnchor.constraint(equalTo: farvouriteName.bottomAnchor),
            farvouritePrice.leadingAnchor.constraint(equalTo: farvouriteImageView.trailingAnchor, constant: 12),
            
            heartImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            heartImage.leadingAnchor.constraint(equalTo: farvouriteImageView.trailingAnchor, constant: 10),
            heartImage.heightAnchor.constraint(equalToConstant: 17),
            heartImage.widthAnchor.constraint(equalToConstant: 17),
            
            ratingLabel.centerYAnchor.constraint(equalTo: farvouriteName.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            starImageView.centerYAnchor.constraint(equalTo: farvouriteName.centerYAnchor),
            starImageView.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -5),
            
            plusButton.centerYAnchor.constraint(equalTo: heartImage.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            quantityLabel.centerYAnchor.constraint(equalTo: heartImage.centerYAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -5),
            
            minusButton.centerYAnchor.constraint(equalTo: heartImage.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -5),
        ])
    }
    
    @objc private func minusButtonTapped() {
        var number = Int(quantityLabel.text ?? "0") ?? 0
        
        if number > 0 {
            number -= 1
            quantityLabel.text = "\(number)"
        }
    }
    
    @objc private func plusButtonTapped() {
        var number = Int(quantityLabel.text ?? "0") ?? 0
        
        number += 1
        quantityLabel.text = "\(number)"
    }
    
    func configure(drink: Drink) {
        farvouriteName.text = drink.name
        farvouritePrice.text = "\(drink.price)$"
        ratingLabel.text = "\(drink.rating)"
        farvouriteImageView.image = UIImage(named: "\(drink.image)")
    }
}

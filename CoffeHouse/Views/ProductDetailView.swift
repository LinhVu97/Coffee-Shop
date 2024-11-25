//
//  ProductDetailView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 14/11/24.
//

import UIKit

class ProductDetailView: UIView {
    var drink: Drink? {
        didSet {
            configure()
        }
    }
    
    private let smallSizeButton = CustomButton(sizeTitleButton: 16, widthButton: 98, heightButton: 37)
    private let mediumSizeButton = CustomButton(sizeTitleButton: 16, widthButton: 98, heightButton: 37)
    private let largeSizeButton = CustomButton(sizeTitleButton: 16, widthButton: 98, heightButton: 37)
    
    private lazy var addToppingView = AddToppingView()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var productSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Coffee Size"
        return label
    }()
    
    private lazy var sizeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var aboutDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id ipsum vivamus velit lorem amet. Tincidunt cras volutpat aliquam porttitor molestie. Netus neque, habitasse id vulputate proin cras. Neque, vel duis sit vel pellentesque tempor. A commodo arcu tortor arcu, elit. "
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
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
        layer.cornerRadius = 30
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Now add all UI elements to contentView
        contentView.addSubview(productSizeLabel)
        contentView.addSubview(sizeStackView)
        contentView.addSubview(aboutLabel)
        contentView.addSubview(aboutDescriptionLabel)
        contentView.addSubview(addToppingView)
        
        sizeStackView.addArrangedSubview(smallSizeButton)
        sizeStackView.addArrangedSubview(mediumSizeButton)
        sizeStackView.addArrangedSubview(largeSizeButton)
        
        smallSizeButton.translatesAutoresizingMaskIntoConstraints = false
        mediumSizeButton.translatesAutoresizingMaskIntoConstraints = false
        largeSizeButton.translatesAutoresizingMaskIntoConstraints = false
        addToppingView.translatesAutoresizingMaskIntoConstraints = false
        
        smallSizeButton.addTarget(self, action: #selector(didSelectSizeButton(_:)), for: .touchUpInside)
        mediumSizeButton.addTarget(self, action: #selector(didSelectSizeButton(_:)), for: .touchUpInside)
        largeSizeButton.addTarget(self, action: #selector(didSelectSizeButton(_:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Make the contentView fill the scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Important: Set the width of contentView equal to scrollView's width
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Set contentView's height dynamically to accommodate content
            productSizeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            productSizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            productSizeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            sizeStackView.topAnchor.constraint(equalTo: productSizeLabel.bottomAnchor, constant: 15),
            sizeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            sizeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            aboutLabel.topAnchor.constraint(equalTo: sizeStackView.bottomAnchor, constant: 12),
            aboutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            aboutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            aboutDescriptionLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10),
            aboutDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            aboutDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            addToppingView.topAnchor.constraint(equalTo: aboutDescriptionLabel.bottomAnchor, constant: 10),
            addToppingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            addToppingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            addToppingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
    
    private func configure() {
        guard let drink = drink else { return }
        
        smallSizeButton.isHidden = true
        mediumSizeButton.isHidden = true
        largeSizeButton.isHidden = true
        
        for size in drink.sizes {
            switch size {
            case "S":
                smallSizeButton.setTitle("Small", for: .normal)
                smallSizeButton.isHidden = false
                smallSizeButton.isSelected = true
            case "M":
                mediumSizeButton.setTitle("Medium", for: .normal)
                mediumSizeButton.isHidden = false
            case "L":
                largeSizeButton.setTitle("Large", for: .normal)
                largeSizeButton.isHidden = false
            default:
                break
            }
        }
        
        addToppingView.configure(price: "\(drink.price)$")
    }
    
    @objc private func didSelectSizeButton(_ sender: CustomButton) {
        smallSizeButton.isSelected = false
        mediumSizeButton.isSelected = false
        largeSizeButton.isSelected = false
        
        sender.isSelected = true
    }
}

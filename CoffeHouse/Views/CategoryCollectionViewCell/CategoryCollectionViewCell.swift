//
//  CategoryCollectionViewCell.swift
//  CoffeHouse
//
//  Created by Linh Vu on 13/11/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let identifier = "CategoryCollectionViewCell"
    
    private lazy var categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor.hex562B1A
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(categoryLabel)
        addSubview(categoryImage)
        
        setupView()
        setupContrainsts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.hex846046.cgColor
        self.layer.cornerRadius = 15
    }
    
    private func setupContrainsts() {
        NSLayoutConstraint.activate([
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            categoryImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryImage.widthAnchor.constraint(equalToConstant: 14),
            categoryImage.heightAnchor.constraint(equalToConstant: 18),
            
            categoryLabel.centerYAnchor.constraint(equalTo: categoryImage.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 	-6)
        ])
    }
    
    func configure(categoryImageName: String, categoryName: String) {
        categoryImage.image = UIImage(named: categoryImageName)
        categoryLabel.text = categoryName
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setGradientColor(color1: .hexCB8A58, color2: .hex562B1A) // Màu nền khi được chọn
                categoryLabel.textColor = .white // Màu chữ khi được chọn
            } else {
                layer.sublayers?.removeAll(where: {$0 is CAGradientLayer})
                backgroundColor = .clear // Màu nền khi không được chọn
                categoryLabel.textColor = UIColor.hex562B1A // Màu chữ ban đầu
            }
        }
    }
}

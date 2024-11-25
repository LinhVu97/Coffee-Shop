//
//  MethodTableViewCell.swift
//  CoffeHouse
//
//  Created by Linh Vu on 25/11/24.
//

import UIKit

class MethodTableViewCell: UITableViewCell {
    let identifier = "MethodTableViewCell"
    
    private lazy var imageMethod: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_apple_payment")
        return imageView
    }()
    
    private lazy var nameMethod: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        clipsToBounds = true
        backgroundColor = .hexF4F4F4
        layer.borderWidth = 1
        layer.borderColor = UIColor.hexE3E3E3.cgColor
        
        addSubview(imageMethod)
        addSubview(nameMethod)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageMethod.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageMethod.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageMethod.widthAnchor.constraint(equalToConstant: 18),
            imageMethod.heightAnchor.constraint(equalToConstant: 18),
            
            nameMethod.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameMethod.leadingAnchor.constraint(equalTo: imageMethod.trailingAnchor, constant: 10),
        ])
    }
    
    func config(image: UIImage, name: String) {
        imageMethod.image = image
        nameMethod.text = name
    }
}

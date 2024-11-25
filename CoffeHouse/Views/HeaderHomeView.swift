//
//  HeaderHomeView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 12/11/24.
//

import UIKit

class HeaderHomeView: UIView {
    
    private lazy var locationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_location_color")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "New York, USA"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var phoneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_phone_color")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var searchField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Search..."
        field.font = .systemFont(ofSize: 15)
        field.layer.cornerRadius = 20
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1
        
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .gray
        
        let leftview = UIView(frame: CGRect(x: 0, y: 10, width: 40, height: 20))
        icon.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        leftview.addSubview(icon)
        field.leftViewMode = .always
        field.leftView = leftview
        
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(locationImage)
        addSubview(locationLabel)
        addSubview(phoneImage)
        addSubview(searchField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            locationImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            locationImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            locationImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 5),
            
            phoneImage.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            phoneImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            searchField.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 30),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            searchField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//
//  ProfileHeaderView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 11/11/24.
//

import UIKit

class DetailSetting: UIView {
    
    private var nameSetting: String?
    private var imageSetting: UIImage?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_edit_button"), for: .normal)
        return button
    }()
    
    init(imageSetting: UIImage?, nameSetting: String) {
        if let imageSetting = imageSetting {
            self.imageSetting = imageSetting
        }
        
        self.nameSetting = nameSetting
        super.init(frame: .zero)
        clipsToBounds = true
        addSubview(imageView)
        addSubview(textLabel)
        addSubview(editButton)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        if let imageSetting = self.imageSetting {
            imageView.image = imageSetting
        }
        
        if let nameSetting = self.nameSetting {
            textLabel.text = nameSetting
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 15),
            
            editButton.rightAnchor.constraint(equalTo: rightAnchor),
            editButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func addTargetToButton(target: Any?, action: Selector) {
        editButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

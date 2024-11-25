//
//  ProfileViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 8/11/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var phoneSetting = DetailSetting(imageSetting: UIImage(named: "ic_phone"),
                                             nameSetting: "+380483746375")
    private lazy var locationSetting = DetailSetting(imageSetting: UIImage(named: "ic_location"),
                                                nameSetting: "New York, USA")
    private lazy var cartSetting = DetailSetting(imageSetting: UIImage(named: "ic_cart"),
                                            nameSetting: "My Cart")
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image_profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserDefaults.standard.string(forKey: "name")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var editNameButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_edit_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        return button
    }()
    
    private lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "ic_logout")
        configuration.title = "Logout"
        configuration.baseForegroundColor = .hexCB8A58
        configuration.imagePlacement = .trailing // Đặt ảnh bên phải tiêu đề
        configuration.imagePadding = 15 // Khoảng cách giữa ảnh và tiêu đề
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Thiết lập cấu hình cho button
        button.configuration = configuration
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        view.addSubview(headerImageView)
        view.addSubview(nameLabel)
        view.addSubview(editNameButton)
        view.addSubview(settingLabel)
        view.addSubview(phoneSetting)
        view.addSubview(locationSetting)
        view.addSubview(cartSetting)
        view.addSubview(logoutButton)
        
        phoneSetting.translatesAutoresizingMaskIntoConstraints = false
        locationSetting.translatesAutoresizingMaskIntoConstraints = false
        cartSetting.translatesAutoresizingMaskIntoConstraints = false
        
        editNameButton.addTarget(self, action: #selector(didTapEditName), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        phoneSetting.addTargetToButton(target: self, action: #selector(didTapEditPhone))
        locationSetting.addTargetToButton(target: self, action: #selector(didTapEditLocation))
        cartSetting.addTargetToButton(target: self, action: #selector(didTapEditCart))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerImageView.widthAnchor.constraint(equalToConstant: 90),
            headerImageView.heightAnchor.constraint(equalToConstant: 90),
            
            nameLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            editNameButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            editNameButton.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10),
            editNameButton.widthAnchor.constraint(equalToConstant: 24),
            editNameButton.heightAnchor.constraint(equalToConstant: 24),
            
            settingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            settingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            
            phoneSetting.topAnchor.constraint(equalTo: settingLabel.bottomAnchor, constant: 20),
            phoneSetting.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            phoneSetting.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            
            locationSetting.topAnchor.constraint(equalTo: phoneSetting.bottomAnchor, constant: 30),
            locationSetting.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            locationSetting.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            
            cartSetting.topAnchor.constraint(equalTo: locationSetting.bottomAnchor, constant: 30),
            cartSetting.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            cartSetting.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            
            logoutButton.topAnchor.constraint(equalTo: cartSetting.bottomAnchor, constant: 30),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50)
        ])
    }
    
    @objc private func didTapEditName() {
        print("Edit Name")
    }
    
    @objc private func didTapEditPhone() {
        print("Edit Phone")
    }
    
    @objc private func didTapEditLocation() {
        print("Edit Location")
    }
    
    @objc private func didTapEditCart() {
        print("Edit Cart")
    }
    
    @objc private func didTapLogout() {
        UserDefaults.standard.set(nil, forKey: "name")
        dismiss(animated: true)
    }
}

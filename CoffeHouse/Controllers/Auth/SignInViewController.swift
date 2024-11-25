//
//  SignInViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 8/11/24.
//

import UIKit

class SignInViewController: UIViewController {
    private var users: [User] = []
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let welcomeBackLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back"
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login to your account"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 60))
        field.backgroundColor = .systemBackground
        field.leftViewMode = .always
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(named: "light_brown_color")?.cgColor
        field.layer.masksToBounds = true
        return field
    }()
    
    private let phoneField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 60))
        field.backgroundColor = .systemBackground
        field.leftViewMode = .always
        field.layer.cornerRadius = 5
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(named: "light_brown_color")?.cgColor
        field.layer.masksToBounds = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "login_button"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        parseUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImage.frame = view.bounds
        welcomeBackLabel.frame = CGRect(x: view.frame.width/5, y: view.safeAreaInsets.top+100, width: view.frame.width-120, height: 45)
        titleLabel.frame = CGRect(x: view.frame.width/5, y: welcomeBackLabel.bottom+7, width: view.frame.width-120, height: 45)
        nameLabel.frame = CGRect(x: view.frame.width/4, y: titleLabel.bottom+60, width: view.frame.width-75, height: 20)
        nameField.frame = CGRect(x: view.frame.width/5, y: nameLabel.bottom+5, width: view.frame.width-140, height: 60)
        phoneLabel.frame = CGRect(x: view.frame.width/4, y: nameField.bottom+20, width: view.frame.width-75, height: 20)
        phoneField.frame = CGRect(x: view.frame.width/5, y: phoneLabel.bottom+5, width: view.frame.width-140, height: 60)
        loginButton.frame = CGRect(x: view.frame.width/5, y: phoneField.bottom+60, width: view.frame.width-140, height: 60)
    }
    
    private func setupView() {
        view.addSubview(backgroundImage)
        view.addSubview(welcomeBackLabel)
        view.addSubview(titleLabel)
        view.addSubview(nameField)
        view.addSubview(nameLabel)
        view.addSubview(phoneField)
        view.addSubview(phoneLabel)
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    private func parseUsers() {
        guard let usersData = ParseJson.shared.parseData(User.self, fileName: "Users") else { return }
        
        users = usersData
    }
    
    @objc private func didTapLogin() {
        guard let name = self.nameField.text,
                !name.isEmpty,
              let phone = self.phoneField.text,
                !phone.isEmpty else {
            return
        }
        
        for user in users {
            if name == user.username && phone == user.password {
                UserDefaults.standard.set(user.name, forKey: "name")
                
                let vc = TabbarViewController()
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                present(navVC, animated: true)
                return
            }
        }
        
        print("Invalid login credentials")
        alert()
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Error", message: "Invalid login credentials", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            alert.dismiss(animated: true)
            self?.nameField.text = ""
            self?.phoneField.text = ""
        }))
        present(alert, animated: true)
    }
}

//
//  FavouriteViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 8/11/24.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    private lazy var listFarvouriteView = ListFarvouriteView()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstrainst()
    }
    
    private func setupView() {
        view.addSubview(searchField)
        view.addSubview(listFarvouriteView)
        
        listFarvouriteView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstrainst() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            searchField.heightAnchor.constraint(equalToConstant: 50),
            
            listFarvouriteView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 45),
            listFarvouriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            listFarvouriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            listFarvouriteView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

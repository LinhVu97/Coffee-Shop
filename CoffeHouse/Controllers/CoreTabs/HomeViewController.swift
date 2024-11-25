//
//  HomeViewController.swift
//  CoffeHouse
//
//  Created by Linh Vu on 8/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var headerHomeView = HeaderHomeView()
    private lazy var categoryView = CategoryView()
    private lazy var drinkView = DrinkView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        parseCategories()
        parseDrinks()
    }
    
    private func setupView() {
        view.addSubview(headerHomeView)
        view.addSubview(categoryView)
        view.addSubview(drinkView)
        
        headerHomeView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        drinkView.translatesAutoresizingMaskIntoConstraints = false
        
        drinkView.drinkDelegate = self
    }
    
    private func parseCategories() {
        guard let categoriesData = ParseJson.shared.parseData(Category.self, fileName: "Categories") else { return }
        
        categoryView.categories = categoriesData
    }
    
    private func parseDrinks() {
        guard let drinksData = ParseJson.shared.parseData(Drink.self, fileName: "Drinks") else { return }
        
        drinkView.drinks = drinksData
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            headerHomeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            headerHomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            headerHomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            headerHomeView.heightAnchor.constraint(equalToConstant: view.height*0.18),
            
            categoryView.topAnchor.constraint(equalTo: headerHomeView.bottomAnchor, constant: 30),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            categoryView.heightAnchor.constraint(equalToConstant: view.height*0.18),
            
            drinkView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 0),
            drinkView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            drinkView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            drinkView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension HomeViewController: DrinkViewDelegate {
    func didSelectDrink(_ drink: Drink) {
        let vc = DrinkDetailViewController()
        vc.drink = drink
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//
//  DrinkView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 13/11/24.
//

import UIKit

protocol DrinkViewDelegate: AnyObject {
    func didSelectDrink(_ drink: Drink)
}

class DrinkView: UIView {
    private lazy var drinkViewCell = DrinkViewCollectionViewCell()
    var drinks: [Drink] = []
    
    var drinkDelegate: DrinkViewDelegate?
    
    private lazy var drinkCollectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DrinkViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: drinkViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(drinkCollectionView)
        
        setupConstrants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrants() {
        NSLayoutConstraint.activate([
            drinkCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            drinkCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            drinkCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            drinkCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemsSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                                   heightDimension: .estimated(100))
            let item  = NSCollectionLayoutItem(layoutSize: itemsSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
            group.interItemSpacing = .fixed(20)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            return section
        }
    }
}

extension DrinkView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: drinkViewCell.identifier,
                                                      for: indexPath) as! DrinkViewCollectionViewCell
        let drink = drinks[indexPath.row]
        cell.configure(drinkData: drink)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drink = drinks[indexPath.row]
        drinkDelegate?.didSelectDrink(drink)
    }
}

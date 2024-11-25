//
//  ListFarvouriteView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 18/11/24.
//

import UIKit

class ListFarvouriteView: UIView {
    
    var drinks: [Drink] = []
    
    private lazy var listFarvouriteTableViewCell = ListFarvouriteViewTableViewCell()
    
    private lazy var listFarvouriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListFarvouriteViewTableViewCell.self,
                           forCellReuseIdentifier: listFarvouriteTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var noFarvouriteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Favorite"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        clipsToBounds = true
        addSubview(listFarvouriteTableView)
        addSubview(noFarvouriteLabel)
        
        setupNotificationCenter()
        setupConstrainst()
        setupNoFarvouriteLabel()
    }
    
    private func setupConstrainst() {
        NSLayoutConstraint.activate([
            listFarvouriteTableView.topAnchor.constraint(equalTo: topAnchor),
            listFarvouriteTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listFarvouriteTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listFarvouriteTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupNoFarvouriteLabel() {
        NSLayoutConstraint.activate([
            noFarvouriteLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noFarvouriteLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func updateNoFarvouriteLabel() {
        if drinks.isEmpty {
            listFarvouriteTableView.isHidden = true
            noFarvouriteLabel.isHidden = false
        } else {
            listFarvouriteTableView.isHidden = false
            noFarvouriteLabel.isHidden = true
        }
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addToFarvourite(_:)),
                                               name: Notification.Name("AddToFarvourite"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeFromFarvourite(_:)),
                                               name: Notification.Name("RemoveFromFarvourite"),
                                               object: nil)
    }
    
    @objc private func addToFarvourite(_ notification: Notification) {
        if let drink = notification.userInfo?["drink"] as? Drink {
            drinks.append(drink) // Cập nhật danh sách yêu thích
            updateNoFarvouriteLabel()
            listFarvouriteTableView.reloadData() // Làm mới giao diện
        }
    }

    @objc private func removeFromFarvourite(_ notification: Notification) {
        if let drinkName = notification.userInfo?["drink"] as? Drink {
            drinks.removeAll { $0 == drinkName } // Loại bỏ đồ uống
            updateNoFarvouriteLabel()
            listFarvouriteTableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ListFarvouriteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listFarvouriteTableView.dequeueReusableCell(withIdentifier: listFarvouriteTableViewCell.identifier,
                                                               for: indexPath) as! ListFarvouriteViewTableViewCell
        let drink = drinks[indexPath.row]
        cell.configure(drink: drink)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listFarvouriteTableView.deselectRow(at: indexPath, animated: true)
    }
}

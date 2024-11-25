//
//  ChooseToppingView.swift
//  CoffeHouse
//
//  Created by Linh Vu on 15/11/24.
//

import UIKit

protocol ChooseToppingViewDelegate: AnyObject {
    func didTapMinusButton()
    func didTapPlusButton()
}

class ChooseToppingView: UIView {
    
    var chooseToppingDelegate: ChooseToppingViewDelegate?
    
    private let nameTopping: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var numberTopping: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_minus"), for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_plus"), for: .normal)
        return button
    }()
    
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.masksToBounds = true
        return view
    }()

    init(toppingName: String) {
        self.nameTopping.text = toppingName
        super.init(frame: .zero)
    
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        clipsToBounds = true
        
        addSubview(nameTopping)
        addSubview(numberTopping)
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(seperatorView)
        
        minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTopping.topAnchor.constraint(equalTo: topAnchor),
            nameTopping.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            
            plusButton.centerYAnchor.constraint(equalTo: nameTopping.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            numberTopping.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            numberTopping.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -8),
            
            minusButton.centerYAnchor.constraint(equalTo: numberTopping.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: numberTopping.leadingAnchor, constant: -8),
            
            seperatorView.topAnchor.constraint(equalTo: nameTopping.bottomAnchor, constant: 10),
            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    @objc private func didTapMinus() {
        var number = Int(numberTopping.text ?? "0") ?? 0
        if number > 0 {
            number -= 1
            numberTopping.text = "\(number)"
            
            chooseToppingDelegate?.didTapMinusButton()
        }
    }
    
    @objc private func didTapPlus() {
        var number = Int(numberTopping.text ?? "0") ?? 0
        number += 1
        numberTopping.text = "\(number)"
        
        chooseToppingDelegate?.didTapPlusButton()
    }
}

//
//  DrinkViewCollectionViewCell.swift
//  CoffeHouse
//
//  Created by Linh Vu on 13/11/24.
//

import UIKit

class DrinkViewCollectionViewCell: UICollectionViewCell {
    let identifier = "DrinkViewCollectionViewCell"
    
    var isFarvourite = false
    
    var drink: Drink?
    
    private let smallSizeButton = CustomButton(sizeTitleButton: 6, widthButton: 30, heightButton: 15)
    private let mediumSizeButton = CustomButton(sizeTitleButton: 6, widthButton: 30, heightButton: 15)
    private let largeSizeButton = CustomButton(sizeTitleButton: 6, widthButton: 30, heightButton: 15)
    
    private lazy var farvouriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "ic_heart")
        return imageView
    }()
    
    private lazy var drinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var drinkName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_add_button"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.hexBFBDC0.cgColor
        layer.cornerRadius = 15
        
        addSubview(drinkImageView)
        addSubview(farvouriteImageView)
        addSubview(drinkName)
        addSubview(smallSizeButton)
        addSubview(mediumSizeButton)
        addSubview(largeSizeButton)
        addSubview(priceLabel)
        addSubview(addToCartButton)
        
        smallSizeButton.translatesAutoresizingMaskIntoConstraints = false
        mediumSizeButton.translatesAutoresizingMaskIntoConstraints = false
        largeSizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        smallSizeButton.addTarget(self, action: #selector(didSelectSizeButton(_:)), for: .touchUpInside)
        mediumSizeButton.addTarget(self, action: #selector(didSelectSizeButton(_:)), for: .touchUpInside)
        largeSizeButton.addTarget(self, action: #selector(didSelectSizeButton(_:)), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFarvourite))
        farvouriteImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            farvouriteImageView.topAnchor.constraint(equalTo: drinkImageView.topAnchor, constant: 7),
            farvouriteImageView.trailingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: -7),
            farvouriteImageView.leadingAnchor.constraint(equalTo: drinkImageView.leadingAnchor, constant: 100),
            farvouriteImageView.bottomAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: -77),
            
            drinkImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            drinkImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            drinkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            
            drinkName.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: 7),
            drinkName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            drinkName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
            
            smallSizeButton.topAnchor.constraint(equalTo: drinkName.bottomAnchor, constant: 7),
            smallSizeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            
            mediumSizeButton.centerYAnchor.constraint(equalTo: smallSizeButton.centerYAnchor),
            mediumSizeButton.leadingAnchor.constraint(equalTo: smallSizeButton.trailingAnchor, constant: 2),
            
            largeSizeButton.centerYAnchor.constraint(equalTo: smallSizeButton.centerYAnchor),
            largeSizeButton.leadingAnchor.constraint(equalTo: mediumSizeButton.trailingAnchor, constant: 2),
            
            priceLabel.topAnchor.constraint(equalTo: smallSizeButton.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            
            addToCartButton.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: 55),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            addToCartButton.widthAnchor.constraint(equalToConstant: 30),
            addToCartButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    @objc private func didSelectSizeButton(_ sender: CustomButton) {
        smallSizeButton.isSelected = false
        mediumSizeButton.isSelected = false
        largeSizeButton.isSelected = false
        
        sender.isSelected = true
    }
    
    @objc private func didTapFarvourite() {
        guard let drink = drink else { return }
        
        isFarvourite.toggle()
        
        let imageName = isFarvourite ? "ic_heart_color" : "ic_heart"
        farvouriteImageView.image = UIImage(named: imageName)
        
        if isFarvourite {
            NotificationCenter.default.post(name: Notification.Name("AddToFarvourite"),
                                            object: nil,
                                            userInfo: ["drink": drink])
        } else {
            NotificationCenter.default.post(name: Notification.Name("RemoveFromFarvourite"),
                                            object: nil,
                                            userInfo: ["drink": drink])
        }
    }
    
    @objc private func didTapAddToCart() {
        guard let drink = drink else { return }
        
        let alert = UIAlertController(title: "Success", message: "Added to cart", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            NotificationCenter.default.post(name: Notification.Name("AddToCart"),
                                            object: nil,
                                            userInfo: ["cart": drink])
        }
        alert.addAction(action)
        
        if let topViewController = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows
                .first(where: { $0.isKeyWindow })?.rootViewController {
                
                var presentedVC = topViewController
                while let nextVC = presentedVC.presentedViewController {
                    presentedVC = nextVC
                }
                
                presentedVC.present(alert, animated: true, completion: nil)
            }
    }
    
    func configure(drinkData: Drink) {
        self.drink = drinkData
        
        drinkImageView.image = UIImage(named: drinkData.image)
        drinkName.text = drinkData.name
        priceLabel.text = "\(drinkData.price)$"
        
        smallSizeButton.isHidden = true
        mediumSizeButton.isHidden = true
        largeSizeButton.isHidden = true
        
        for drinkSize in drinkData.sizes {
            switch drinkSize {
            case "S":
                smallSizeButton.setTitle("S", for: .normal)
                smallSizeButton.isHidden = false
                smallSizeButton.isSelected = true
            case "M":
                mediumSizeButton.setTitle("M", for: .normal)
                mediumSizeButton.isHidden = false
            case "L":
                largeSizeButton.setTitle("L", for: .normal)
                largeSizeButton.isHidden = false
            default:
                break
            }
        }
    }
}

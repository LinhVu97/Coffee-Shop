import UIKit

class CategoryView: UIView {
    private lazy var collectionViewCell = CategoryCollectionViewCell()
    
    var categories: [Category] = [] {
        didSet {
            categoryCollectionView.reloadData()
            selectFirstCell()
        }
    }
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: collectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(categoryLabel)
        addSubview(categoryCollectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            categoryCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            categoryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemsSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                                   heightDimension: .estimated(30))
            let item  = NSCollectionLayoutItem(layoutSize: itemsSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item]) // Đảm bảo 3 items một hàng
            group.interItemSpacing = .fixed(10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            return section
        }
    }
    
    private func selectFirstCell() {
        if !categories.isEmpty {
            let indexPath = IndexPath(row: 0, section: 0)
            categoryCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }
    }
}

extension CategoryView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCell.identifier,
                                                      for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        cell.configure(categoryImageName: category.image, categoryName: category.content)
        
        return cell
    }
}

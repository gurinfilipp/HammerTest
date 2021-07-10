//
//  CategoriesView.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import UIKit
import PinLayout

protocol FooterViewTapDelegate: AnyObject {
    func moveTo(section: IndexPath)
}


class CategoriesView: UIView {
    
    private var categories: [String] = []
    private var arrayOfButtons: [UIButton] = []
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 40
        flowLayout.itemSize = CGSize(width: 150, height: 40)
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    var onTap: ((Int)->())?
    
    weak var delegate: MenuViewController?
    
    init(frame: CGRect, categories: [String]) {
        super.init(frame: frame)
        
            
        self.categories = categories
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pin.all()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CollectionView Cell")
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoriesView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionView Cell", for: indexPath) as? CategoryCell else { return .init() }
        
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        onTap?(indexPath.row)
        let newIndexPath = IndexPath(row: 0, section: indexPath.row + 1)
        delegate?.moveTo(section: newIndexPath)
    }
    
}

//
//  CategoriesView.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import UIKit
import PinLayout

protocol FooterViewTapDelegate: AnyObject {
    func moveTo(category: String)
}

class CategoriesView: UIView {
    
    private var categories: [String] = []
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 40
        flowLayout.itemSize = CGSize(width: 150, height: 40)
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    var currentCategory: Int = 0
    weak var delegate: MenuViewController?
    
    init(frame: CGRect, categories: [String]) {
        super.init(frame: frame)
        self.categories = categories
        addSubview(collectionView)
        collectionViewSetup()
    }
    
    func collectionViewSetup() {
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
    
    func categoryChanged(with category: Int) {
        self.currentCategory = category
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: category, section: 0), at: .centeredHorizontally, animated: true)
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
        cell.configure(with: categories[indexPath.row])
        if indexPath.row == currentCategory {
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            cell.makeTitleBold()
        } else {
            cell.backgroundColor = UIColor.clear
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
            cell.makeTitleStandart()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentCategory = indexPath.row
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.moveTo(category: categories[indexPath.row])
    }
}


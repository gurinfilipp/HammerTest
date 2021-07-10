//
//  CategoriesView.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import UIKit
import PinLayout

class CategoriesView: UIView {
    
    private var categories: [String] = []
    private var arrayOfButtons: [UIButton] = []
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 30
        flowLayout.minimumInteritemSpacing = 40
        flowLayout.itemSize = CGSize(width: 150, height: 40)
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //
    //        setupButtons()
    //    }
    
    
    init(frame: CGRect, categories: [String]) {
        super.init(frame: frame)
        
        self.categories = categories
        addSubview(collectionView)
        setupButtons()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pin.all()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .green
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CollectionView Cell")
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        let numberOfCategories: Int = categories.count
        
        
        
        //        for (index, category) in categories.enumerated() {
        
//        for category in categories {
//            let button = createButton(for: category)
//            arrayOfButtons.append(button)
//
//        }
//        print(arrayOfButtons)
//
//        let buttonsStackView = UIStackView(arrangedSubviews: arrayOfButtons)
//        addSubview(buttonsStackView)
//        buttonsStackView.pin.all()
//        buttonsStackView.axis = .horizontal
//        buttonsStackView.alignment = .center
//
//        buttonsStackView.distribution = .equalSpacing
//
//        buttonsStackView.spacing = 30
        
        
        
        //            if index == 0 {
        //                let button = createButton(for: category)
        //                addSubview(button)
        //                button.pin.left(16).height(30).width(80).vCenter()
        //            }
        //            let button = createButton(for: category)
        //            addSubview(button)
        //            button.pin
        //                .after(of: button)
//        //                .marginLeft(16).height(30).width(80).vCenter()
//        //        }
//    }
//
//    func createButton(for category: String) -> UIButton {
//        let button = UIButton(type: .system)
//        button.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
//        button.layer.cornerRadius = 15
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.red.cgColor
//
//        button.setTitle(category, for: .normal)
//        button.tintColor = .red
//        return button
//    }
    
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
        cell.layer.borderColor = UIColor.red.cgColor
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

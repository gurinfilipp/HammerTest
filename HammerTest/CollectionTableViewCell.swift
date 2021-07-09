//
//  CollectionTableViewCell.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    var adsArray: [String] = ["menuIcon", "orderIcon"]
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 30
        flowLayout.itemSize = CGSize(width: 150, height: 40)
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.pin.all()
        self.collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
    }
    
    func configure(with ad: UIImage) {
        
    }
    
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell  else {
            debugPrint("cannot create cell")
            return .init()
        }
        print("hey")

        cell.configure(with: adsArray[indexPath.row])
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 110, height: collectionView.bounds.height - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}



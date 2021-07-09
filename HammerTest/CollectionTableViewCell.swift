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
        flowLayout.itemSize = CGSize(width: 150, height: 40)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
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
        cell.backgroundColor = .black
        cell.configure(with: adsArray[indexPath.row])
        
        return cell
        
        
    }
}

final class CollectionCell: UICollectionViewCell {
    private let adImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .green
        contentView.addSubview(adImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adImageView.pin.all()
    }
    
    func configure(with ad: String) {
        adImageView.image = UIImage(named: ad)
    }
}

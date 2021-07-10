//
//  CollectionCell.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import Foundation
import UIKit

final class CollectionCell: UICollectionViewCell {
    private let adImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(adImageView)
        adImageView.layer.cornerRadius = 10
        adImageView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adImageView.pin.all()
    }
    
    func configure(with ad: UIImage) {
        adImageView.image = ad
    }
}

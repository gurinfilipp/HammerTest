//
//  CategoryCell.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import Foundation
import UIKit

final class CategoryCell: UICollectionViewCell {
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.tintColor = .red
        label.textColor = .red
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
        categoryLabel.layer.cornerRadius = 10
        categoryLabel.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryLabel.pin.all()
        categoryLabel.textAlignment = .center
    }
    
    func configure(with category: String) {
        categoryLabel.text = category
    }
}

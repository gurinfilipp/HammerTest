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
        label.textColor = UIColor.red.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    func makeTitleBold() {
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        categoryLabel.textColor = .red
    }
    
    func makeTitleStandart() {
        categoryLabel.textColor = UIColor.red.withAlphaComponent(0.5)
        categoryLabel.font = UIFont.systemFont(ofSize: 14)
    }
}

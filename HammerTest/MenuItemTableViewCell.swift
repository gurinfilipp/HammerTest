//
//  MenuItemTableViewCell.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import UIKit
import PinLayout

final class MenuItemTableViewCell: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        
        return label
    }()
    private let itemImageView: UIImageView = UIImageView()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        
        return label
    }()
    private let minimumPriceButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .red
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [nameLabel, descriptionLabel, itemImageView, minimumPriceButton].forEach {
            contentView.addSubview($0)
        }
        
   
        itemImageView.pin
            .vCenter()
            .left(16)
            .width(140)
            .height(140)
        
        nameLabel.pin
            .top(30)
            .after(of: itemImageView)
            .marginLeft(40)
            .right(16)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: nameLabel)
            .marginTop(15)
            .after(of: itemImageView)
            .marginLeft(40)
            .right(16)
            .sizeToFit(.width)
        
        minimumPriceButton.pin
            .below(of: descriptionLabel)
            .marginTop(15)
            .right(16)
            .width(100)
            .height(40)
    }
    
    func configure(with item: MenuItem) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        
        itemImageView.image = UIImage(named: item.imageName)?.withRenderingMode(.alwaysOriginal)
        
        minimumPriceButton.setTitle("от \(item.minimumPrice) р", for: .normal)
        
    }
    
}

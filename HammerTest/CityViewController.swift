//
//  CityViewController.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import Foundation
import UIKit
import PinLayout

class CityViewController: UIViewController {
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "ViewController для выбора города"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(placeholderLabel)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(dismissViewController))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(dismissViewController))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        placeholderLabel.pin.vCenter().hCenter().width(view.bounds.width).height(100)
    }
    
    @objc
    private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}

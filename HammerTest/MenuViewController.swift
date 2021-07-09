//
//  MenuViewController.swift
//  HammerTest
//
//  Created by Филипп Гурин on 09.07.2021.
//

import UIKit
import PinLayout

class MenuViewController: UIViewController {

    private var currentCity: String = "Москва ᐯV⌄"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: currentCity , style: .plain, target: self, action: #selector(cityButtonTapped))
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .systemGroupedBackground
        navigationController?.navigationBar.shadowImage = UIImage()
    
    }

    @objc
    private func cityButtonTapped() {
        print(#function)
    }
    
}


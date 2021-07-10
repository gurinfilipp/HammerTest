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
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        
        return tableView
    }()
    
    private var menuItems: [MenuItem] = [MenuItem(name: "pizzizzizzizzizzizzizza", imageName: "menuIcon", description: "bla bla bla", minimumPrice: 350), MenuItem(name: "pizza izza", imageName: "menuIcon", description: "blizzai zzaizz aizz aizzai zzaizzaa bla bla", minimumPrice: 350), MenuItem(name: "pizza", imageName: "menuIcon", description: "bla bla bla", minimumPrice: 350), MenuItem(name: "pizza", imageName: "menuIcon", description: "bla bla bla", minimumPrice: 350)]
    private var adsArray: [UIImage] = [UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!, UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!]
    private var categories: [String] = ["pizza", "combo", "desserts", "drinks"]
   // private var categories: [String] = ["pizza"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: "MenuItemTableViewCell")
        
  //      tableView.tableFooterView = CategoriesView(frame: CGRect(x: 0, y: 0, width: 400, height: 70), categories: categories)
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
    }
    
    private func setupTableView() {
        //tableView.separatorInset = .zero
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

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return menuItems.count
        default:
            return 0
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return .none
        case 1:
            let view = CategoriesView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70), categories: categories)
            return view
        default:
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 60
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = CollectionTableViewCell()
            cell.configure(with: adsArray)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell", for: indexPath) as? MenuItemTableViewCell else { return .init() }
            cell.configure(with: menuItems[indexPath.row])
            return cell
        default:
            return .init()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 200
        default:
            return 50
        }
    }
    
}



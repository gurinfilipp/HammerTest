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
    
    
    
    private var menuItems: [MenuItem] = [MenuItem(name: "Ветчина и грибы", imageName: "menuIcon", description: "Ветчина, шампиньоны, увеличенная порция моцареллы", minimumPrice: 345), MenuItem(name: "Баварские колбаски", imageName: "menuIcon", description: "Баварские колбаски, ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", minimumPrice: 345), MenuItem(name: "Нежный лосось", imageName: "menuIcon", description: "Лосось, томаты черри, моцарелла, соус песто", minimumPrice: 345), MenuItem(name: "Пицца четыре сыра", imageName: "menuIcon", description: "Соус карбонара, сыр моцарелла, сыр пармезан, сыр маасдам, сыр рокфор", minimumPrice: 395)]
    private var adsArray: [UIImage] = [UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!, UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!]
    private var categories: [String] = ["Пицца", "Комбо", "Десерты", "Напитки"]
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: "MenuItemTableViewCell")
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
    }
    
    private func setupTableView() {
        
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: currentCity , style: .plain, target: self, action: #selector(cityButtonTapped))
        navigationController?.navigationBar.isTranslucent = false
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
        return categories.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return menuItems.count
        default:
        //    return 0
            return menuItems.count
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return .none
        }
        let view = CategoriesView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70), categories: categories)
        view.delegate = self
      //  view.currentCategory = section - 1
        view.currentCategory = section - 1
    //    view.changeCategory(for: section - 1)
  print("current category must be \(section - 1)")
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 60
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
            //return .init()
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell", for: indexPath) as? MenuItemTableViewCell else { return .init() }
            cell.configure(with: menuItems[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 130
        case 1:
            return 200
        default:
         //   return 50
        return 200
        }
    }

    
    
}

extension MenuViewController: FooterViewTapDelegate {
    func moveTo(section: IndexPath) {
        
        self.tableView.scrollToRow(at: section, at: .top, animated: true)
    }
    
 
    
    
}


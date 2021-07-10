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
    
    
    
    private var menuItems: [MenuItem] = [ MenuItem(name: "Coca-Cola", imageName: "menuIcon", description: "Cola", minimumPrice: 80, mealType: .drinks), MenuItem(name: "Fanta", imageName: "menuIcon", description: "Fanta", minimumPrice: 80, mealType: .drinks), MenuItem(name: "Sprite", imageName: "menuIcon", description: "Sprite", minimumPrice: 80, mealType: .drinks), MenuItem(name: "Ветчина и грибы", imageName: "HandM", description: "Ветчина, шампиньоны, увеличенная порция моцареллы", minimumPrice: 345, mealType: .pizza), MenuItem(name: "Баварские колбаски", imageName: "BS", description: "Баварские колбаски, ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус", minimumPrice: 345, mealType: .pizza), MenuItem(name: "Нежный лосось", imageName: "TS", description: "Лосось, томаты черри, моцарелла, соус песто", minimumPrice: 345, mealType: .pizza), MenuItem(name: "Пицца четыре сыра", imageName: "TS", description: "Соус карбонара, сыр моцарелла, сыр пармезан, сыр маасдам, сыр рокфор", minimumPrice: 395, mealType: .pizza), MenuItem(name: "2x2", imageName: "accountIcon", description: "combo for 2 people", minimumPrice: 999, mealType: .combo), MenuItem(name: "Тирамису", imageName: "orderIcon", description: "Классический кофейный десерт", minimumPrice: 240, mealType: .desert), MenuItem(name: "Чизкейк", imageName: "orderIcon", description: "Чизкейк прямиком из Нью-Йорка!", minimumPrice: 300, mealType: .desert), MenuItem(name: "Coca-Cola", imageName: "menuIcon", description: "Cola", minimumPrice: 80, mealType: .drinks), MenuItem(name: "Fanta", imageName: "menuIcon", description: "Fanta", minimumPrice: 80, mealType: .drinks), MenuItem(name: "Sprite", imageName: "menuIcon", description: "Sprite", minimumPrice: 80, mealType: .drinks)]
    private var adsArray: [UIImage] = [UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!, UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!]
//    private var categories: [String] = ["Пицца", "Комбо", "Десерты", "Напитки"]
    let categories: [String] = MealType.allCases.map { $0.rawValue }
    var categoryPoints: [Int] = []
    var currentCategory: MealType = .pizza
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: "MenuItemTableViewCell")
        
        setupNavigationBar()
        setupTableView()
        menuItems = sortMenuArray()
        categoryPoints = findNewCategoryPoint()
    }
    
    func sortMenuArray() -> [MenuItem] {
        let sortedAlphArray = menuItems.sorted { $0.name < $1.name }
        var sortedMenuArray: [MenuItem] = []
        for item in sortedAlphArray {
            if item.mealType == .pizza {
                sortedMenuArray.append(item)
            }
        }
        for item in sortedAlphArray {
            if item.mealType == .combo {
                sortedMenuArray.append(item)
            }
        }
        for item in sortedAlphArray {
            if item.mealType == .desert {
                sortedMenuArray.append(item)
            }
        }
        for item in sortedAlphArray {
            if item.mealType == .drinks {
                sortedMenuArray.append(item)
            }
        }
        return sortedMenuArray
    }
    
    func findNewCategoryPoint() -> [Int] {
        var categoriesPointArray: [Int] = []
        if let pizzaCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .pizza }) {
            categoriesPointArray.append(pizzaCategoryIndex)
        }
        if let comboCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .combo }) {
            categoriesPointArray.append(comboCategoryIndex)
        }
        if let desertCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .desert }) {
            categoriesPointArray.append(desertCategoryIndex)
        }
        if let drinksCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .drinks }) {
            categoriesPointArray.append(drinksCategoryIndex)
        }
        print(categoriesPointArray)
        return categoriesPointArray
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
        let vc = UINavigationController(rootViewController: CityViewController())
        present(vc, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == categoryPoints[1] + 1 {
            self.currentCategory = .combo
        } else if indexPath.row == categoryPoints[2] + 1 {
            self.currentCategory = .desert
        } else if indexPath.row == categoryPoints[3] + 1 {
            self.currentCategory = .drinks
        }
        print(currentCategory)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return .none
        }
        let view = CategoriesView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70), categories: categories)
        view.delegate = self
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
            return .init()
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
    func moveTo(category: String) {
        guard let firstCategoryItem = self.menuItems.firstIndex(where: { $0.mealType.rawValue == category }) else { return }
        self.tableView.scrollToRow(at: IndexPath(row: firstCategoryItem, section: 1), at: .top, animated: true)
    }
    
    
   
    
 
    
    
}


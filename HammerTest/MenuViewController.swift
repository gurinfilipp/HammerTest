//
//  MenuViewController.swift
//  HammerTest
//
//  Created by Филипп Гурин on 09.07.2021.
//

import UIKit
import PinLayout

class MenuViewController: UIViewController {
    
    private var currentCity: String = "Москва ᐯ"
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        
        return tableView
    }()
    
    
    private var menuItems: [MenuItem] = [] {
        didSet {
            tableView.reloadData()
            print("number of items in menu items is \(menuItems.count)")
        }
    }

    var sortedMenuArray: [MenuItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var adsArray: [UIImage] = [UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!, UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!]

    let categories: [String] = MealType.allCases.map { $0.rawValue }
    var categoryPoints: [Int] = []
    var currentCategory: MealType = .pizza
    var finalArray: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllMenuItems()

        tableView.reloadData()
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: "MenuItemTableViewCell")
        
        setupNavigationBar()
        setupTableView()
        
    //    categoryPoints = findNewCategoryPoint()
     //   let newArray = sortMenuArray()
      //  print(newArray)
      //  menuItems = sortMenuArray()
        tableView.reloadData()
    //    sortedMenuArray = sortMenuArray()
    }
    
    func fetchAllMenuItems() {
     let serialQueue = DispatchQueue(label: "SerialQueue")
        serialQueue.async {
           
        let group = DispatchGroup()
        group.enter()
        NetworkManager.fetchMenu(for: "pizza") { response in
            let dataToShow = response.results
            dataToShow.forEach {
                $0.mealType = .pizza
            }
            self.menuItems = dataToShow
            group.leave()
            print("Pizza fetched")
        }
        
//            DispatchQueue.main.async {
//                print("MY PIZZA ITEMS SARE \(self.menuItems)")
//                self.sortedMenuArray = self.sortMenuArray()
//                self.tableView.reloadData()
//            }
        
        group.wait()
        
            group.enter()
        NetworkManager.fetchMenu(for: "pasta") { pastaResults in
            let dataToShow = pastaResults.results
            print("pasta is ocming")
            dataToShow.forEach {
                $0.mealType = .combo
            }
            self.menuItems.append(contentsOf: dataToShow)
            group.leave()
            print("MY PASTA ITEMS SARE \(self.menuItems)")
        }
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
  
            group.enter()
        NetworkManager.fetchMenu(for: "dessert") { pizzaResults in
            let dataToShow = pizzaResults.results
            print("desertiscoming")
            dataToShow.forEach {
                $0.mealType = .desert
            }
            self.menuItems.append(contentsOf: dataToShow)
            group.leave()
            print("MY  Desrtt ITEMS SARE \(self.menuItems)")
        }
        
            DispatchQueue.main.async {
                
              //  self.sortedMenuArray = self.sortMenuArray()
                self.tableView.reloadData()
            }
    
            group.enter()
            NetworkManager.fetchMenu(for: "drinks") { pizzaResults in
                let dataToShow = pizzaResults.results
                print("drinks are coming")
                dataToShow.forEach {
                    $0.mealType = .drinks
                }
                self.menuItems.append(contentsOf: dataToShow)
                group.leave()
                print("MY  drinks ITEMS SARE \(self.menuItems)")
            }
        
                DispatchQueue.main.async {
                    
                  //  self.sortedMenuArray = self.sortMenuArray()
                    self.tableView.reloadData()
                }
        
            print("well, full menu items are \(self.menuItems)")
        }
            }
    
    
//    func fetchAllMenuItems() {     WORKING WITH SHUFFLE
//
//        let serialQueue = DispatchQueue(label: "SerialQueue")
//        serialQueue.sync {
//        NetworkManager.fetchMenu(for: "pizza") { pizzaResults in
//            let dataToShow = pizzaResults.results
//            dataToShow.forEach {
//                $0.mealType = .pizza
//            }
//            self.menuItems = dataToShow
//        }
//        }
//            DispatchQueue.main.async {
//                print("MY PIZZA ITEMS SARE \(self.menuItems)")
//                self.sortedMenuArray = self.sortMenuArray()
//                self.tableView.reloadData()
//            }
//
//        serialQueue.sync {
//        NetworkManager.fetchMenu(for: "pasta") { pastaResults in
//            let dataToShow = pastaResults.results
//            print("pasta is ocming")
//            dataToShow.forEach {
//                $0.mealType = .combo
//            }
//            self.menuItems.append(contentsOf: dataToShow)
//            print("MY PASTA ITEMS SARE \(self.menuItems)")
//        }
//        }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//        serialQueue.sync {
//        NetworkManager.fetchMenu(for: "dessert") { pizzaResults in
//            let dataToShow = pizzaResults.results
//            print("desertiscoming")
//            dataToShow.forEach {
//                $0.mealType = .desert
//            }
//            self.menuItems.append(contentsOf: dataToShow)
//            print("MY  Desrtt ITEMS SARE \(self.menuItems)")
//        }
//        }
//            DispatchQueue.main.async {
//
//              //  self.sortedMenuArray = self.sortMenuArray()
//                self.tableView.reloadData()
//            }
//        serialQueue.sync {
//
//            NetworkManager.fetchMenu(for: "drinks") { pizzaResults in
//                let dataToShow = pizzaResults.results
//                print("drinks are coming")
//                dataToShow.forEach {
//                    $0.mealType = .drinks
//                }
//                self.menuItems.append(contentsOf: dataToShow)
//                print("MY  drinks ITEMS SARE \(self.menuItems)")
//            }
//        }
//                DispatchQueue.main.async {
//
//                  //  self.sortedMenuArray = self.sortMenuArray()
//                    self.tableView.reloadData()
//                }
//
//        print("well, full menu items are \(menuItems)")
//            }
            
           
     
        
     
    
    
    
    
    func sortMenuArray() -> [MenuItem] {
  //      let sortedAlphArray = menuItems.sorted { $0.title < $1.title }
        var sortedMenuArray: [MenuItem] = []

        for item in menuItems {
            if item.mealType == .pizza  {
                print("item title is \(item.title)")
                sortedMenuArray.append(item)
            }
        }
        for item in menuItems {
            if item.mealType == .combo {
                sortedMenuArray.append(item)
            }
        }
        for item in menuItems {
            if item.mealType == .desert {
                sortedMenuArray.append(item)
            }
        }
        for item in menuItems {
            if item.mealType == .drinks {
                sortedMenuArray.append(item)
            }
        }
        return sortedMenuArray
    }
    
//    func findNewCategoryPoint() -> [Int] {
//        var categoriesPointArray: [Int] = []
//        if let pizzaCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .pizza }) {
//            categoriesPointArray.append(pizzaCategoryIndex)
//        }
//        if let comboCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .combo }) {
//            categoriesPointArray.append(comboCategoryIndex)
//        }
//        if let desertCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .desert }) {
//            categoriesPointArray.append(desertCategoryIndex)
//        }
//        if let drinksCategoryIndex = self.sortMenuArray().firstIndex(where: { $0.mealType == .drinks }) {
//            categoriesPointArray.append(drinksCategoryIndex)
//        }
//        print(categoriesPointArray)
//        return categoriesPointArray
//    }
    
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
         //   return sortedMenuArray.count
        return menuItems.count
        default:
     return 0
        }
    }
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == categoryPoints[1] + 1 {
//            self.currentCategory = .combo
//        } else if indexPath.row == categoryPoints[2] + 1 {
//            self.currentCategory = .desert
//        } else if indexPath.row == categoryPoints[3] + 1 {
//            self.currentCategory = .drinks
//        }
//        print(currentCategory)
//    }
    
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
         //   cell.configure(with: sortedMenuArray[indexPath.row])
            
            
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
            return 240
        default:
         //   return 50
        return 200
        }
    }

    
    
}

extension MenuViewController: FooterViewTapDelegate {
    func moveTo(category: String) {
        guard let firstCategoryItem = self.menuItems.firstIndex(where: { $0.mealType?.rawValue == category }) else { return }
        self.tableView.scrollToRow(at: IndexPath(row: firstCategoryItem, section: 1), at: .top, animated: true)
    }
    
    
   
    
 
    
    
}


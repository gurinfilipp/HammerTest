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
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private var menuItems: [MenuItem] = []
    private var adsArray: [UIImage] = [UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!, UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!]
    let categories: [String] = MealType.allCases.map { $0.rawValue }
    var allCategoriesShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: "MenuItemTableViewCell")
        
        fetchAllMenuItems()
        setupNavigationBar()
        setupAI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
        activityIndicator.pin.hCenter().vCenter().width(50).height(50).sizeToFit()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: currentCity , style: .plain, target: self, action: #selector(cityButtonTapped))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .systemGroupedBackground
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupAI() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func fetchAllMenuItems() {
        let globalSerialQueue = DispatchQueue(label: "GlobalSerialQueue")
        let serialQueue = DispatchQueue(label: "SerialQueue")
        globalSerialQueue.async {
            let group = DispatchGroup()
            group.enter()
            
            NetworkManager.fetchMenu(for: "pizza", on: serialQueue) { response in
                let dataToShow = response.results
                dataToShow.forEach {
                    $0.mealType = .pizza
                }
                self.menuItems = dataToShow
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                    self.activityIndicator.stopAnimating()
                }
                group.leave()
            }
            group.wait()
            
            group.enter()
            NetworkManager.fetchMenu(for: "pasta", on: serialQueue) { response in
                let dataToShow = response.results
                dataToShow.forEach {
                    $0.mealType = .combo
                }
                self.menuItems.append(contentsOf: dataToShow)
                group.leave()
            }
            group.wait()
            
            group.enter()
            NetworkManager.fetchMenu(for: "dessert", on: serialQueue) { response in
                let dataToShow = response.results
                dataToShow.forEach {
                    $0.mealType = .desert
                }
                self.menuItems.append(contentsOf: dataToShow)
                group.leave()
            }
            group.wait()
            
            group.enter()
            NetworkManager.fetchMenu(for: "drinks", on: serialQueue) { response in
                let dataToShow = response.results
                dataToShow.forEach {
                    $0.mealType = .drinks
                }
                self.menuItems.append(contentsOf: dataToShow)
                group.leave()
            }
            group.wait()
            
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                self.allCategoriesShown = true
                self.activityIndicator.stopAnimating()
            }
        }
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var categoriesPoints: [Int] = []
        for category in categories {
            guard let firstCategoryItem = self.menuItems.firstIndex(where: { $0.mealType?.rawValue == category }) else { return }
            categoriesPoints.append(firstCategoryItem)
        }
        let subviewsArray = tableView.subviews
        let categoryView = subviewsArray.first {
            $0.tag == 1001
        }
        guard let castedCategoryView = categoryView as? CategoriesView else { return }
        if categoriesPoints.contains(indexPath.row - 2) {
            let newCategoryNumber = indexPath.row - 2
            guard let newCategoryNumberInArray = categoriesPoints.firstIndex(of: newCategoryNumber) else {return}
            let newCategory = self.categories[newCategoryNumberInArray]
            let newCategoryEnum = MealType.allCases.first {
                $0.rawValue == newCategory
            }
            let newCategoryIndex = MealType.allCases.firstIndex {
                newCategoryEnum == $0
            }
            castedCategoryView.categoryChanged(with: newCategoryIndex ?? 0)
            }
        }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return .none
        }
        let view = CategoriesView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70), categories: categories)
        view.delegate = self
        view.tag = 1001
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
            return 240
        default:
            return 200
        }
    }
}

extension MenuViewController: FooterViewTapDelegate {
    func moveTo(category: String) {
        guard let firstCategoryItem = self.menuItems.firstIndex(where: { $0.mealType?.rawValue == category }) else { return }
        guard self.allCategoriesShown else { return }
        self.tableView.scrollToRow(at: IndexPath(row: firstCategoryItem, section: 1), at: .top, animated: true)
    }
}


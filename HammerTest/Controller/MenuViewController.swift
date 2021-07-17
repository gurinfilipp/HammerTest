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
    private var menuItems: [MenuItem] = []
    private var adsArray: [UIImage] = [UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!, UIImage(named: "ad1")!, UIImage(named: "ad2")!, UIImage(named: "ad3")!]
    let categories: [String] = MealType.allCases.map { $0.rawValue }
    var allCategoriesShown = false {
        didSet {
            tableView.reloadData()
            self.menuItemsCache = []
            saveMenuCache()
        }
    }
    var menuItemsCache: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restoreData()
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: "MenuItemTableViewCell")
        
        fetchAllMenuItems()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: currentCity , style: .plain, target: self, action: #selector(cityButtonTapped))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .systemGroupedBackground
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    private func restoreData() {
        guard let fileURL = getFileURL() else {
            return
        }
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedMenuItemsData = try? Data(contentsOf: fileURL),
           let decodedMenuItems = try?
            propertyListDecoder.decode(Array<MenuItem>.self,
                                       from: retrievedMenuItemsData) {
            self.menuItemsCache = decodedMenuItems
        }
    }
    
    private func saveMenuCache() {
        guard let fileURL = getFileURL() else {
            return
        }
        for item in self.menuItems {
            guard let newItem = item.copy() as? MenuItem else {
                return
            }
            self.menuItemsCache.append(newItem)
        }
        let propertyListEncoder = PropertyListEncoder()
        let encodedMenuItems = try? propertyListEncoder.encode(self.menuItemsCache)
        try? encodedMenuItems?.write(to: fileURL, options: .noFileProtection)
    }
    
    private func getFileURL() -> URL? {
        let documentsUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileUrl = documentsUrl?.appendingPathComponent("menuItems").appendingPathExtension("plist")
        return fileUrl
    }
    
    private func fetchAllMenuItems() {
        self.menuItems = []
        let globalSerialQueue = DispatchQueue(label: "GlobalSerialQueue")
        let serialQueue = DispatchQueue(label: "SerialQueue")
        let group = DispatchGroup()
        globalSerialQueue.async {
            for category in MealType.allCases {
                group.enter()
                NetworkManager.fetchMenu(for: category.rawValue, on: serialQueue) { response in
                    let dataToShow = response.results
                    dataToShow.forEach {
                        $0.mealType = MealType(rawValue: category.rawValue)
                    }
                    self.menuItems.append(contentsOf: dataToShow)
                    if category == MealType.allCases[0] {
                        DispatchQueue.main.async {
                            self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
                        }
                    }
                    group.leave()
                }
                group.wait()
            }
            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
                self.allCategoriesShown = true
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
            let numberOfRows = self.allCategoriesShown ? menuItems.count : menuItemsCache.count
            return numberOfRows
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let visibleRows = tableView.indexPathsForVisibleRows
        guard let visibleRowsFromSectionOne = visibleRows?.filter({
            $0.section == 1
        }) else { return }
        var arrayOfIndices: [Int] = []
        for row in visibleRowsFromSectionOne {
            arrayOfIndices.append(row.row)
        }
        var arrayOfMenuItems: [MenuItem] = []
        for menuItemNumber in arrayOfIndices {
            let dataArray = self.allCategoriesShown ? menuItems : menuItemsCache
            arrayOfMenuItems.append(dataArray[menuItemNumber])
        }
        let mappedArrayOfMenuItems = arrayOfMenuItems.map { ($0.mealType, 1) }
        let counts = Dictionary(mappedArrayOfMenuItems, uniquingKeysWith: +)
        var mostUsed: MealType = .pizza
        if let (value, _) = counts.max(by: {$0.1 < $1.1}) {
            mostUsed = value
        }
        let subviewsArray = tableView.subviews
        let categoryView = subviewsArray.first {
            $0.tag == 1001
        }
        guard let castedCategoryView = categoryView as? CategoriesView else { return }
        castedCategoryView.categoryChanged(with: MealType.allCases.firstIndex(where: {
            $0 == mostUsed
        })!)
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
            if self.allCategoriesShown {
                cell.configure(with: menuItems[indexPath.row])
            } else {
                cell.configure(with: menuItemsCache[indexPath.row])
            }
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
        let array = self.allCategoriesShown ? menuItems : menuItemsCache
        guard let firstCategoryItem = array.firstIndex(where: { $0.mealType.rawValue == category }) else { return }
        self.tableView.scrollToRow(at: IndexPath(row: firstCategoryItem, section: 1), at: .top, animated: true)
    }
}


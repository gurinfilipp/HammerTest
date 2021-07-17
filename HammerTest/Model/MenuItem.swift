//
//  MenuItem.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import Foundation

struct JsonResults: Decodable {
    var results: [MenuItem]
}

enum MealType: String, CaseIterable, Codable {
    case pizza = "Pizza"
    case combo = "Pasta"
    case desert = "Dessert"
    case drinks = "Drinks"
    
    init(rawValue: String) {
        switch rawValue {
        case "Pizza"  : self = .pizza
        case "Pasta"  : self = .combo
        case "Dessert": self = .desert
        case "Drinks": self = .drinks
        default: self = .pizza
        }
    }
}

class MenuItem: Codable, NSCopying {
    var title: String
    var image: String
    //    var description: String
    //   var minimumPrice: Int
    var mealType: MealType?
    
    init(title: String, image: String, mealType: MealType) {
        self.title = title
        self.image = image
        self.mealType = mealType
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = MenuItem(title: title, image: image, mealType: mealType ?? .pizza)
        return copy
    }
}

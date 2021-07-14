//
//  MenuItem.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import Foundation
import RealmSwift

struct JsonResults: Decodable {
    var results: [MenuItem]
}

enum MealType: String, CaseIterable, Decodable, Encodable {
    case pizza = "Пицца"
    case combo = "Паста"
    case desert = "Десерты"
    case drinks = "Напитки"
}

class MenuItem: Decodable, NSCopying, Encodable {
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

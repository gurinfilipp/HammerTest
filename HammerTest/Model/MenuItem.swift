//
//  MenuItem.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import Foundation

enum MealType: String, CaseIterable {
    case pizza = "Пицца"
    case combo = "Комбо"
    case desert = "Десерт"
    case drinks = "Напитки"
}

struct MenuItem {
    var name: String
    var imageName: String
    var description: String
    var minimumPrice: Int
    
    var mealType: MealType
}

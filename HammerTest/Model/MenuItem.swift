//
//  MenuItem.swift
//  HammerTest
//
//  Created by Филипп Гурин on 10.07.2021.
//

import Foundation

enum MealType: String, CaseIterable, Decodable {
    case pizza = "Пицца"
    case combo = "Паста"
    case desert = "Десерты"
    case drinks = "Напитки"
}

class MenuItem: Decodable {
    var title: String
    var image: String
//    var description: String
 //   var minimumPrice: Int
    
    var mealType: MealType?
}


struct Results: Decodable {
  //  var results: [MenuItem]
    var results: [MenuItem]
   // var offset: Int
   // var number: Int
   // var totalResults: Int
}

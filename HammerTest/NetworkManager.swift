//
//  NetworkManager.swift
//  HammerTest
//
//  Created by Филипп Гурин on 11.07.2021.
//

import Foundation
import Alamofire

final class NetworkManager {
        
    let shared = NetworkManager()
    
    private init() {}

    static func fetchMenu(for category: String, completion: @escaping(_ data: Results) -> ()) {
        var urlComponents = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")!
            urlComponents.queryItems = [
                "query" : category,
                "apiKey" : "d327cf53f9934f2792abd72c3e0981d2"
            ].map { URLQueryItem(name: $0.key, value: $0.value) }

       let request = AF.request(urlComponents)
        request.responseDecodable(of: Results.self) { response in
            guard let data = response.value else { return }
            completion(data)
        }
    }
}





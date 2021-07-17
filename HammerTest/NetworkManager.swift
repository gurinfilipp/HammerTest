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

    static func fetchMenu(for category: String, on queue: DispatchQueue, completion: @escaping(_ data: JsonResults) -> ()) {
        var urlComponents = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")!
            urlComponents.queryItems = [
                "query" : category,
                "apiKey" : "77e5f605336042a987175e5a6421b822"
            ].map { URLQueryItem(name: $0.key, value: $0.value) }
        let request = AF.request(urlComponents)
        request.responseDecodable(of: JsonResults.self, queue: queue) { response in
            guard let data = response.value else { return }
            completion(data)
        }
    }
}





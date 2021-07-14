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

    static func fetchMenu(for category: String, on queue: DispatchQueue, completion: @escaping(_ data: Results) -> ()) {
        var urlComponents = URLComponents(string: "https://api.spoonacular.com/recipes/complexSearch")!
            urlComponents.queryItems = [
                "query" : category,
                "apiKey" : "9df481a31a6a445ea9db910a919141b7"
            ].map { URLQueryItem(name: $0.key, value: $0.value) }
        let request = AF.request(urlComponents)
        request.responseDecodable(of: Results.self, queue: queue) { response in
            guard let data = response.value else { return }
            completion(data)
        }
    }
}





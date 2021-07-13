//
//  NavigationMenuService.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation
import BrightFutures

class NavigationMenuService {
 
    
    func getItemsFromAPI() -> Future<[NavigationResponseModel], Error>{
        let promise = Promise<[NavigationResponseModel], Error>()
        let url = URL(string: API.navigation.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { print(error!); return }
            guard let data = data else { print("No data"); return }
            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }.resume()
        return promise.future
    }
    
}

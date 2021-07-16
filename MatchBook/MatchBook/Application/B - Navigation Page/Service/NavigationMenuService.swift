//
//  NavigationMenuService.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation
import BrightFutures

class NavigationMenuService {
 
    func getItemsFromAPI() -> Future<NavigationResponseModel, Error>{
        let promise = Promise<NavigationResponseModel, Error>()
        
        let url = URL(string: API.navigation.rawValue)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return promise.failure(error!)
            }
            guard let data = data else {
                let error = CustomMDVError.getNavigationItemError("No data availables")
                return promise.failure(error)
            }
            let decoder = JSONDecoder()
            do {
                let jsonResponse = try decoder.decode([NavigationResponseModel].self, from: data)
                
                let navResponseModelContainer = NavigationResponseModelContainer(itemsList: jsonResponse)
                if navResponseModelContainer.itemsList.count > 0, navResponseModelContainer.itemsList[0].name == "Sport" {
                    let navResponseModel = navResponseModelContainer.itemsList[0]
                    promise.success(navResponseModel)
                }
                
            } catch {
                promise.failure(error)
            }
        }.resume()
        return promise.future
    }

    
}

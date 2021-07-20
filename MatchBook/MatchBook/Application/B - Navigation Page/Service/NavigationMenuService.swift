//
//  NavigationMenuService.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation
import Combine
//import BrightFutures


class NavigationMenuService {
 
    static func getItemsFromAPI() -> AnyPublisher<NavigationResponseModel?, CustomMDVError> {
        let url = API.returnURL(for: .navigation)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        return session.dataTaskPublisher(for: request)
          .tryMap { response in
            guard let httpURLResponse = response.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                throw CustomMDVError.getNavigationItemError("No data availables")
            }
            
            let jsonResponse = try JSONDecoder().decode([NavigationResponseModel].self, from: response.data)
            let navResponseModelContainer = NavigationResponseModelContainer(itemsList: jsonResponse)
            if navResponseModelContainer.itemsList.count > 0, navResponseModelContainer.itemsList[0].name == "Sport" {
                let navResponseModel: NavigationResponseModel = navResponseModelContainer.itemsList[0]
                return navResponseModel
            } else {
                return nil
            }
          }
//          .decode(type: [NavigationResponseModel].self, decoder: JSONDecoder())
          .mapError { CustomMDVError.map($0) }
          .eraseToAnyPublisher()
    }
    
    
    /*
    func getItemsFromAPI() -> Future<NavigationResponseModel, Error>{
        let promise = Promise<NavigationResponseModel, Error>()
        let url = API.returnURL(for: .navigation)

        if ProcessInfo.processInfo.environment["ENV_SCHEME"] == "PRODUCTION" {
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
                do {
                    let jsonResponse = try JSONDecoder().decode([NavigationResponseModel].self, from: data)
                    let navResponseModelContainer = NavigationResponseModelContainer(itemsList: jsonResponse)
                    if navResponseModelContainer.itemsList.count > 0, navResponseModelContainer.itemsList[0].name == "Sport" {
                        let navResponseModel: NavigationResponseModel = navResponseModelContainer.itemsList[0]
                        promise.success(navResponseModel)
                    } else {
                        let error = CustomMDVError.getNavigationItemError("No data availables")
                        promise.failure(error)
                    }
                } catch {
                    promise.failure(error)
                }
            }.resume()
        } else { // ProcessInfo.processInfo.environment["ENV_SCHEME"] == "MOCK"
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let jsonResponse = try JSONDecoder().decode([NavigationResponseModel].self, from: data)
                let navResponseModelContainer = NavigationResponseModelContainer(itemsList: jsonResponse)
                if navResponseModelContainer.itemsList.count > 0, navResponseModelContainer.itemsList[0].name == "Sport" {
                    let navResponseModel = navResponseModelContainer.itemsList[0]
                    promise.success(navResponseModel)
                } else {
                    let error = CustomMDVError.getNavigationItemError("No data availables")
                    promise.failure(error)
                }
            } catch {
                promise.failure(error)
            }
        }
        return promise.future
    }
 */
    
}

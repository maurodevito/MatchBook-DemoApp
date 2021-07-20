//
//  EventsService.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation
import Combine
//import BrightFutures

class EventsService {
    
    static func getEventsFromAPI(urlEventName: String) -> AnyPublisher<EventsResponseModel, CustomMDVError> {
        let urlString = "\(API.events.rawValue)&tag-url-names=\(urlEventName)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        return session.dataTaskPublisher(for: request)
            .tryMap { response in
                guard let httpURLResponse = response.response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
                    throw CustomMDVError.getNavigationItemError("No data availables")
                }
                return response.data
            }
            .decode(type: EventsResponseModel.self, decoder: JSONDecoder())
            .retry(3)
            .mapError { CustomMDVError.map($0) }
            .eraseToAnyPublisher()
    }
    

}

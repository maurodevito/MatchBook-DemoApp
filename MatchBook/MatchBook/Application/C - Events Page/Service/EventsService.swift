//
//  EventsService.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation
import BrightFutures

class EventsService {
    
    
    func getEventsFromAPI(urlEventName: String) -> Future<EventsResponseModel, Error> {
        let promise = Promise<EventsResponseModel, Error>()
        let urlString = "\(API.events.rawValue)&tag-url-names=\(urlEventName)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
                let jsonResponse = try decoder.decode(EventsResponseModel.self, from: data)
                let eventResponseModel: EventsResponseModel = jsonResponse
                promise.success(eventResponseModel)
            } catch {
                promise.failure(error)
            }
        }.resume()
        return promise.future
    }

}

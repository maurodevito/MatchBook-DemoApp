//
//  EventsResponseModel.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation


struct EventsResponseModel: Codable {

    var events: [EventsEventResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case events
    }
}


struct EventsEventResponseModel: Codable {
    
    var name: String?
    var start: String?
    var markets: [EventsMarketResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case start
        case markets
    }
}


struct EventsMarketResponseModel: Codable {
    var name: String
    var runners: [EventsRunnersResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case name
        case runners
    }

}


struct EventsRunnersResponseModel: Codable {
    var withdrawn: Bool?
    var prices: [EventsPricesResponseModel]?
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case withdrawn
        case prices
        case name
    }
}


struct EventsPricesResponseModel: Codable {
    var odds: Double
    var side: String
    
    enum CodingKeys: String, CodingKey {
        case odds
        case side
    }
}

//
//  EndPoints.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

enum API: String {
    case navigation = "https://www.matchbook.com/edge/rest/navigation"
    case events = "https://www.matchbook.com/edge/rest/events?language=en&currency=EUR&exchange-type=back-lay&odds-type=DECIMAL&price-depth=1&per-page=100&market-states=open&runner-states=open&market-auto-sequence=true"
    
    
    static func returnURL(for key: API) -> URL {
        
        var retURL: URL
        switch key {
        case .navigation:
            if ProcessInfo.processInfo.environment["ENV_SCHEME"] == "PRODUCTION" {
                retURL = URL(string: key.rawValue)!
            } else {
                let fileMock = Bundle.main.path(forResource: "navigation", ofType: "mock")!
                retURL = URL(fileURLWithPath: fileMock)
            }
        case .events:
            if ProcessInfo.processInfo.environment["ENV_SCHEME"] == "PRODUCTION" {
                retURL = URL(string: key.rawValue)!
            } else {
                let fileMock = Bundle.main.path(forResource: "events", ofType: "mock")!
                retURL = URL(fileURLWithPath: fileMock)
            }
        }
        return retURL
    }
}

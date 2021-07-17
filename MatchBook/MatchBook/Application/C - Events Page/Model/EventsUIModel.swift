//
//  EventsUIModel.swift
//  MatchBook
//
//  Created by Mauro De Vito on 15/07/2021.
//

import Foundation

struct EventsUIModel: Equatable {

    var events: [EventSingleUIModel]
    
    static func == (lhs: EventsUIModel, rhs: EventsUIModel) -> Bool {
        let isEqual = lhs.events == rhs.events
        return isEqual
    }
    
    init(eventsRespModel: EventsResponseModel) {
        var events = [EventSingleUIModel]()
        for oneEvent in eventsRespModel.events {
            
            let eventName = oneEvent.name ?? "-"
            var eventDate: String = "-"
            if let dateInput = oneEvent.start {
                let dateFormatter = DateFormatter()
                let tempLocale = dateFormatter.locale
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                let date = dateFormatter.date(from: dateInput)!
                dateFormatter.dateFormat = "dd/MM/yy HH:mm"
                dateFormatter.locale = tempLocale
                eventDate = dateFormatter.string(from: date)
            }
            
            
            var runners = [EventRunnerUIModel]()
            var market = "-"
            
            if let markets = oneEvent.markets, markets.count > 0 {
                let firstMarket = markets[0]
                market = firstMarket.name
                for aRunner in firstMarket.runners {
                    
                    let runnerName = aRunner.name
                    var firstBackPrice = "NO BACK"
                    var firstLayPrice = "NO LAY"
                    
                    if let prices = aRunner.prices {
                        for aPrice in prices {
                            if aPrice.side == "lay" && firstLayPrice == "NO LAY" {
                                firstLayPrice = String(format: "%.2f", aPrice.odds) 
                            }
                            if aPrice.side == "back" && firstBackPrice == "NO BACK" {
                                firstBackPrice = String(format: "%.2f", aPrice.odds)
                            }
                        }
                    }
                    runners.append(EventRunnerUIModel(name: runnerName, firstBackPrice: firstBackPrice, firstLayPrice: firstLayPrice))
                }
            }
            
            let newEvent = EventSingleUIModel(name: eventName, date: eventDate, market: market, runners: runners)
            events.append(newEvent)
        }
        self.events = events
    }
    
    private func convertDate(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return  dateFormatter.string(from: date!)
        }
}

struct EventSingleUIModel: Equatable {
    
    var name: String
    var date: String
    var market: String
    var runners: [EventRunnerUIModel]

    static func == (lhs: EventSingleUIModel, rhs: EventSingleUIModel) -> Bool {
        let isEqual: Bool = (
                                (lhs.name == rhs.name) &&
                                (lhs.date == rhs.date) &&
                                (lhs.market == rhs.market) &&
                                (lhs.runners == rhs.runners)
                            )
        return isEqual
    }
}


struct EventRunnerUIModel: Equatable {
    var name: String
    var firstBackPrice: String
    var firstLayPrice: String
    
    static func == (lhs: EventRunnerUIModel, rhs: EventRunnerUIModel) -> Bool {
        let isEqual: Bool = (
                                (lhs.name == rhs.name) &&
                                (lhs.firstBackPrice == rhs.firstBackPrice) &&
                                (lhs.firstLayPrice == rhs.firstLayPrice)
                            )
        return isEqual
    }

}

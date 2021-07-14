//
//  EventsManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation

class EventsManager: BaseManager {
    weak var viewControllerDelegate: EventsControllerDelegate!
    
}


extension EventsManager: EventsManagerDelegate {
    func viewControllerDidLoad() {
        // do something
    }
}

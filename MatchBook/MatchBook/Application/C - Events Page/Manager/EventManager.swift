//
//  EventManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation

class EventsManager: BaseManager {
    weak var viewControllerDelegate: EventControllerDelegate!
    
}


extension EventsManager: EventManagerDelegate {
    func viewControllerDidLoad() {
        // do something
    }
}

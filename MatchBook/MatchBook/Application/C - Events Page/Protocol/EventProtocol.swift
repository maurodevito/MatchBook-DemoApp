//
//  EventsProtocol.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation

protocol EventsManagerDelegate: class {
    func viewControllerDidLoad()
    func setModel(model: NavigationItemUIModel)
}

protocol EventsControllerDelegate: BaseControllerDelegate {
    func setModel(model: NavigationItemUIModel)
    func showAlert(errorMessage: String)
    func setEventsModel(model: [EventSingleUIModel])
}

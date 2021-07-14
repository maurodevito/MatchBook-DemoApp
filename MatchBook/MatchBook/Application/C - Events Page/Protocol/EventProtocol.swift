//
//  EventsProtocol.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation

protocol EventsManagerDelegate: class {
    func viewControllerDidLoad()
}

protocol EventsControllerDelegate: BaseControllerDelegate {
    func setModel(model: NavigationUIModel)
}

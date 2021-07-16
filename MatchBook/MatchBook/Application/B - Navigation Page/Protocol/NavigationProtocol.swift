//
//  NavigationProtocol.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

protocol NavigationMenuManagerDelegate: class {
    func viewControllerDidLoad()
    func openEvent()
}

protocol NavigationMenuControllerDelegate: BaseControllerDelegate {
    func gotoEventPage()
    func setModel(model: NavigationUIModel)
    func showAlert(errorMessage: String)
}

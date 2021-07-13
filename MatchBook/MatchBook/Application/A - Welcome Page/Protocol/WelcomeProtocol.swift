//
//  WelcomeProtocol.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

protocol WelcomeManagerDelegate: class {
    func viewControllerDidLoad()
    func openMenu()
}

protocol WelcomeControllerDelegate: BaseControllerDelegate {
    func openNavigationPage()
}

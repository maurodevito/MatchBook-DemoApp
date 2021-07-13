//
//  WelcomeManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation


class WelcomeManager: BaseManager {
    weak var viewControllerDelegate: WelcomeControllerDelegate!
    
}

extension WelcomeManager: WelcomeManagerDelegate {
    func openMenu() {
        self.viewControllerDelegate.openNavigationPage()
    }
    
    
    func viewControllerDidLoad() {
        // any action on viewControllerDidLoad
    }
    
}

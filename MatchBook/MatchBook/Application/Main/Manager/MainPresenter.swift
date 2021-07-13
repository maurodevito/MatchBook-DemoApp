//
//  MainPresenter.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

class MainManager: BasePresenter {
    weak var viewControllerDelegate: MainControllerDelegate!
    
}

extension MainManager: MainPresenterDelegate {
    func viewControllerDidLoad() {
        // viewControllerDidLoad
    }
    
}

//
//  NavigationManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

class NavigationMenuManager: BaseManager {
    var model: NavigationResponseModel?
    
    weak var viewControllerDelegate: NavigationMenuControllerDelegate!
    
    private func getNavigationResponseModel(){
        let service = NavigationMenuService()
        let _ = service.getItemsFromAPI()
    }
}


extension NavigationMenuManager: NavigationMenuManagerDelegate {
    func openEvent() {
        print("manager openEvent")
    }
    
    
    
    func viewControllerDidLoad() {
        self.getNavigationResponseModel()
    }
    
}

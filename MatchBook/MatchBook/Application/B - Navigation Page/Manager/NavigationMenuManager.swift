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
        service.getItemsFromAPI().onSuccess { (responseModel) in
            self.model = responseModel
            let navigationUIModel = NavigationUIModel(navResponseModel: responseModel)
            self.viewControllerDelegate.setModel(model: navigationUIModel)
    
//            self.viewControllerDelegate.setModel(model: listNavUIModel.flatMap({$0}))
        }.onFailure { (error) in
            self.viewControllerDelegate.showAlert(errorMessage: "No data availables")
        }
    }
    
    
}


extension NavigationMenuManager: NavigationMenuManagerDelegate {
    func openEvent() {
        print("manager must openEvent")
    }
    
    
    
    func viewControllerDidLoad() {
        self.getNavigationResponseModel()
    }
    
}

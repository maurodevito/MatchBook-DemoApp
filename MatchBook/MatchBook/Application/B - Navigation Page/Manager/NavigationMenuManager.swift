//
//  NavigationManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

class NavigationMenuManager: BaseManager {
    weak var viewControllerDelegate: NavigationMenuControllerDelegate!
    
    private func getNavigationResponseModel(){
        let service = NavigationMenuService()
        service.getItemsFromAPI().onSuccess { (responseModel) in
            let navigationUIModel = NavigationUIModel(navResponseModel: responseModel)
            self.viewControllerDelegate.hideLoader()
            self.viewControllerDelegate.showTable(model: navigationUIModel)
        }.onFailure { (error) in
            self.viewControllerDelegate.hideLoader()
            self.viewControllerDelegate.showAlert(errorMessage: "No data availables")
        }
    }

}


extension NavigationMenuManager: NavigationMenuManagerDelegate {
    func openEvent() {
        print("manager must openEvent")
    }
    
    func viewControllerDidLoad() {
        self.viewControllerDelegate.showLoader()
        self.getNavigationResponseModel()
    }
    
}

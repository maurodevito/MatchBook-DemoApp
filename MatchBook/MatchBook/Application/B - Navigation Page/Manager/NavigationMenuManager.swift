//
//  NavigationManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation
import Combine

class NavigationMenuManager: BaseManager {
    weak var viewControllerDelegate: NavigationMenuControllerDelegate!
    var observer: AnyCancellable?
    
    private func getNavigationResponseModel(){
        observer = NavigationMenuService.getItemsFromAPI()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print(error)
                    self?.viewControllerDelegate.hideLoader()
                    self?.viewControllerDelegate.showAlert(errorMessage: "No data availables")
                }
            }, receiveValue: { [weak self] (response) in
                if let responseModel = response {
                    let navigationUIModel = NavigationUIModel(navResponseModel: responseModel)
                    self?.viewControllerDelegate.hideLoader()
                    self?.viewControllerDelegate.showTable(model: navigationUIModel)
                    } else { // response == nil
                        self?.viewControllerDelegate.hideLoader()
                        self?.viewControllerDelegate.showAlert(errorMessage: "No data availables")
                    }
                }
            )
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

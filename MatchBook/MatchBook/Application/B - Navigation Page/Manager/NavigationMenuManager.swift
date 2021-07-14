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
        
            let listNavUIModel = responseModel.itemsList.map { (item) -> [NavigationUIModel] in
                // item - Level 0
                var returnItemListName: [NavigationUIModel] = [NavigationUIModel]()
                returnItemListName.append(NavigationUIModel(level: .A, name: item.name))
                
                
                if let subItemList = item.detailsList {
                    // subItem - Level 1
                    let subItemListName: [NavigationUIModel] = subItemList.map { (subItem) -> [NavigationUIModel] in
                        var returnSubItemListName: [NavigationUIModel] = [NavigationUIModel]()
                        returnSubItemListName.append(NavigationUIModel(level: .B, name: subItem.name))
                
                        
                        if let subSubItemList = subItem.detailsList {
                            // subSubItem - Level 2
                            let subSubItemListName: [NavigationUIModel] = subSubItemList.map { (subSubItem) -> NavigationUIModel in
                                return (NavigationUIModel(level: .C, name: subSubItem.name))
                            }
                            returnSubItemListName.append(contentsOf: subSubItemListName)
                        }
                        
                        
                        return returnSubItemListName
                    }.flatMap({ $0 })
                    returnItemListName.append(contentsOf: subItemListName)
                }
                
                
                return returnItemListName
            }
            self.viewControllerDelegate.setModel(model: listNavUIModel.flatMap({$0}))
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

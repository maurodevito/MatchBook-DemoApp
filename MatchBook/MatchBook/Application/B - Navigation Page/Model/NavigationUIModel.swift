//
//  NavigationUIModel.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation

enum NavigationItemLevel: Int {
    case A = 1
    case B
    case C
}


struct NavigationUIModel {

    var items: [NavigationItemUIModel]
    
    
    init(navResponseModel: NavigationResponseModel) {
        var items = [NavigationItemUIModel]()
    
        // read items - Level 1
        if let listItemsLev1 = navResponseModel.detailsList {
            for itemLev1 in listItemsLev1 {
                let urlLevel1 = itemLev1.urlName
                items.append(NavigationItemUIModel(level: .A, name: itemLev1.name, url: urlLevel1))
                
                // read items - Level 2
                if let listItemsLev2 = itemLev1.detailsList {
                    for itemLev2 in listItemsLev2 {
                        let urlVevel2 = "\(itemLev1.urlName),\(itemLev2.urlName)"
                        items.append(NavigationItemUIModel(level: .B, name: itemLev2.name, url: urlVevel2))
                        
                        // read items - Level 3
                        if let listItemsLev3 = itemLev2.detailsList {
                            for itemLev3 in listItemsLev3 {
                                let urlLevel3 = "\(itemLev1.urlName),\(itemLev2.urlName),\(itemLev3.urlName)"
                                items.append(NavigationItemUIModel(level: .C, name: itemLev3.name, url: urlLevel3))
                            }
                        }
                    }
                }
                
            }
        }
        self.items = items
    }
}



struct NavigationItemUIModel {
    var level: NavigationItemLevel
    var name: String
    var url: String
}

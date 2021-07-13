//
//  NavigationResponseModel.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation
struct NavigationResponseModel: Codable {
    var arrayList: [NavigationItemModel]
}

struct NavigationItemModel: Codable {
    var name: String
    var treeID: String
    var id: String
    var urlName: String
    var metaTags: [String]
}




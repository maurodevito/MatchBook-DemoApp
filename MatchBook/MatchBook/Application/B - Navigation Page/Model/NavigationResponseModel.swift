//
//  NavigationResponseModel.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

struct NavigationResponseModel: Codable {
    var itemsList: [NavigationItemModel]
}

struct NavigationItemModel: Codable, Identifiable {
    var name: String
    var treeId: UInt64
    var id: UInt64
    var urlName: String
    var detailsList: [NavigationSubItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case treeId = "tree-id"
        case id
        case urlName = "url-name"
        case detailsList = "meta-tags"
    }

}

struct NavigationSubItemModel: Codable, Identifiable {
    var name: String
    var id: UInt64
    var type: String
    var urlName: String
    var detailsList: [NavigationSubItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case type
        case urlName = "url-name"
        case detailsList = "meta-tags"
    }

}





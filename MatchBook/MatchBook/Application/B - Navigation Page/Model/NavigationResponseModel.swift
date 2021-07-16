//
//  NavigationResponseModel.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

struct NavigationResponseModelContainer: Codable {
    var itemsList: [NavigationResponseModel]
}

struct NavigationResponseModel: Codable, Identifiable {
    var name: String
    var treeId: UInt64
    var id: UInt64
    var urlName: String
    var detailsList: [NavigationLev1ItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case treeId = "tree-id"
        case id
        case urlName = "url-name"
        case detailsList = "meta-tags"
    }

}


struct NavigationLev1ItemModel: Codable, Identifiable {
    var name: String
    var id: UInt64
    var type: String
    var urlName: String
    var detailsList: [NavigationLev2ItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case type
        case urlName = "url-name"
        case detailsList = "meta-tags"
    }

}


struct NavigationLev2ItemModel: Codable, Identifiable {
    var name: String
    var id: UInt64
    var type: String
    var urlName: String
    var detailsList: [NavigationLev3ItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case type
        case urlName = "url-name"
        case detailsList = "meta-tags"
    }

}


struct NavigationLev3ItemModel: Codable, Identifiable {
    var name: String
    var id: UInt64
    var type: String
    var urlName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case type
        case urlName = "url-name"
    }

}

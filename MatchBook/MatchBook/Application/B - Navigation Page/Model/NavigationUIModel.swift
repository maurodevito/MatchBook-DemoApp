//
//  NavigationUIModel.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation

enum NavigationItemLevel: Int {
    case A = 0
    case B
    case C
}


struct NavigationUIModel {
    var level: NavigationItemLevel
    var name: String
}

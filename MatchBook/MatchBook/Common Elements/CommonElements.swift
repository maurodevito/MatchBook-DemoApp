//
//  CommonElements.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import Foundation

enum CustomMDVError: Error {
    case getNavigationItemError(String)
    case other(Error)
    
    static func map(_ error: Error) -> CustomMDVError {
      return (error as? CustomMDVError) ?? .other(error)
    }
}

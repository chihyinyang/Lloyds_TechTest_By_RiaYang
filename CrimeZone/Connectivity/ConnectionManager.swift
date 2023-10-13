//
//  ConnectionManager.swift
//  CrimeZone
//
//  Created by 楊智茵 on 07/10/2023.
//

import Foundation
import Reachability

class ConnectionManager {
    let reachability = try! Reachability()
    
    func noInternet() -> Bool {
        return reachability.connection == .unavailable
    }
    
    func isConnected() -> Bool {
        return reachability.connection != .unavailable
    }
}

//
//  LoadigState.swift
//  CrimeZone
//
//  Created by 楊智茵 on 07/10/2023.
//

import Foundation

enum LoadingState<E: Error>: Equatable {
    case idle
    case loading
    case loaded
    case failed(E)
    case noInternet
    
    static func == (lhs: LoadingState<E>, rhs: LoadingState<E>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loaded):
            return true
        case (.loaded, .loaded):
            return true
        case (.failed(_), .failed(_)):
            return true
        case (.noInternet, .noInternet):
            return true
        default:
            return false
        }
    }
}

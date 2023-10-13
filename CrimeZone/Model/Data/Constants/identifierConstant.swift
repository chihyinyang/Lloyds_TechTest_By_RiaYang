//
//  identifierConstant.swift
//  CrimeZone
//
//  Created by 楊智茵 on 12/10/2023.
//

import Foundation

enum IdentifierConstant {
    // main
    case mainViewController
    // shuffle
    case shuffleArrowButton(index: Int)
    case shuffleContentView(index: Int)
    // detail
    case detailViewController
    case detailArrowButton
    
    func getIdentifier() -> String {
        switch self {
        // main
        case .mainViewController:
            return "mainViewController"
        // shuffle
        case .shuffleArrowButton(let index):
            return "shuffleArrowButton_\(index)"
        case .shuffleContentView(let index):
            return "shuffleContentView_\(index)"
        // detail
        case .detailViewController:
            return "detailViewController"
        case .detailArrowButton:
            return "detailArrowButton"
        }
    }
}

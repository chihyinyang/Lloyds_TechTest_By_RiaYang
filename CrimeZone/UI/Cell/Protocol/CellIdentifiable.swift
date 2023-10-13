//
//  CellIdentifiable.swift
//  CrimeZone
//
//  Created by 楊智茵 on 09/10/2023.
//

import Foundation

import UIKit

protocol CellReuseId { }

extension CellReuseId {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: CellReuseId {}
extension UITableViewCell: CellReuseId {}
extension UITableViewHeaderFooterView: CellReuseId {}

//
//  ArrowButton.swift
//  CrimeZone
//
//  Created by 楊智茵 on 08/10/2023.
//

import UIKit

class ArrowButton: UIButton {

    var imageState: ArrowButtonImageState = .up {
        didSet {
            switch imageState {
            case .up:
                self.setImage(UIImage(named: "shuffle_arrow_up"), for: .normal)
            case .down:
                self.setImage(UIImage(named: "shuffle_arrow_down"), for: .normal)
            }
        }
    }
}

//
//  UIView+Ext.swift
//  CrimeZone
//
//  Created by 楊智茵 on 07/10/2023.
//
import UIKit

extension UIView {
    func applyBlurEffect(with style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    func setAccessibilityIdentifier(by identifier: IdentifierConstant) {
        self.accessibilityIdentifier = identifier.getIdentifier()
    }
}

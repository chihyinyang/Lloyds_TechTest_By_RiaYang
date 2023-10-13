//
//  DetailViewTransition.swift
//  CrimeZone
//
//  Created by 楊智茵 on 10/10/2023.
//

import Foundation
import UIKit
import SnapKit

class DetailViewTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - enum
    enum TransitionType {
        case present
        case dismiss
    }
    
    // MARK: - view
    private lazy var arrowButton: ArrowButton = {
        let button = ArrowButton()
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 235, green: 235, blue: 235)
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    // MARK: - properties
    var currentImageViewFrame: CGRect = .zero {
        didSet {
            imageView.frame = currentImageViewFrame
        }
    }
    
    var originImageViewFrame: CGRect = .zero
    
    var imageURLString: String? {
        didSet {
            if let imageURLString = imageURLString,
               let url = URL(string: imageURLString) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "shuffle_unavailableImage"))
            }
        }
    }
    
    var backgroundStartAlpha: CGFloat = 0 {
        didSet {
            backgroundView.alpha = backgroundStartAlpha
        }
    }
    
    /// transitionType
    private let type: TransitionType
    
    /// time duration
    private let duration: TimeInterval = 0.2
        
    init(type: TransitionType) {
        self.type = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    /// handle transitions with different types
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        switch type {
        case .present:
            presentAnimation(using: transitionContext, toViewController: toViewController)
        case .dismiss:
            dismissAnimation(using: transitionContext, toViewController: toViewController, fromViewController: fromViewController)
        }
    }
    
    /// present viewController transition animation
    private func presentAnimation(using transitionContext: UIViewControllerContextTransitioning, toViewController: UIViewController) {
        let containerView = transitionContext.containerView
        // add views
        backgroundView.alpha = 0
        containerView.addSubview(backgroundView)
        containerView.addSubview(imageView)
        // setup background
        backgroundView.alpha = 1
        // setup button
        imageView.addSubview(arrowButton)
        arrowButton.imageState = .down
        arrowButton.frame = CGRect(x: imageView.frame.width - 65,
                                   y: imageView.frame.height - 65,
                                   width: 45,
                                   height: 45)
        // animation
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            
            self.imageView.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: 500)
            self.arrowButton.frame = CGRect(x: self.imageView.frame.maxX - 65,
                                            y: self.imageView.frame.maxY - 65,
                                            width: 45,
                                            height: 45)
        } completion: { _ in
            containerView.addSubview(toViewController.view)
            self.arrowButton.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
            self.imageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
    
    /// dismiss viewController transition animation
    private func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning, toViewController: UIViewController, fromViewController: UIViewController) {
        let containerView = transitionContext.containerView
        fromViewController.view.alpha = 0
        // add views
        containerView.addSubview(backgroundView)
        containerView.addSubview(imageView)
        // setup arrow button
        imageView.addSubview(arrowButton)
        arrowButton.imageState = .up
        arrowButton.frame = CGRect(x: self.imageView.frame.maxX - 65,
                                        y: self.imageView.frame.maxY - 65,
                                        width: 45,
                                        height: 45)
        
        // animation
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn) {

            self.imageView.frame = self.originImageViewFrame
            
            self.arrowButton.frame = CGRect(x: self.imageView.frame.width - 65,
                                            y: self.imageView.frame.height - 65,
                                            width: 45,
                                            height: 45)
        } completion: { _ in
            self.backgroundView.alpha = 0
            transitionContext.completeTransition(true)
        }
    }
}

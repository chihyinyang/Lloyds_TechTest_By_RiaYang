//
//  DetailCoordinator.swift
//  CrimeZone
//
//  Created by 楊智茵 on 09/10/2023.
//

import UIKit

class DetailCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var criminal: CriminalItem
    
    var displayImageURLString: String
    
    var displayImageOriginFrame: CGRect
    
    init(navigationController: UINavigationController, criminal: CriminalItem, displayImageURLString: String, displayImageOriginFrame: CGRect) {
        self.navigationController = navigationController
        self.criminal = criminal
        self.displayImageURLString = displayImageURLString
        self.displayImageOriginFrame = displayImageOriginFrame
    }
    
    func start() {
        let viewModel = DetailViewModel(criminal: criminal,
                                        displayImageURLString: displayImageURLString,
                                        displayImageOriginFrame: displayImageOriginFrame)
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }
}

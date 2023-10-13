//
//  MainCoordinator.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let responseService = EndpointResponseService(networkService: NetworkService(), parser: DataParser())
        let viewModel = MainViewModel(responseService: responseService, connectionManager: ConnectionManager())
        let viewController = MainViewController(viewModel: viewModel)
        viewController.navigation = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
protocol MainNavigationDelegate: AnyObject {
    func showDetailPage(criminal: CriminalItem, displayImageURLString: String, displayImageOriginFrame: CGRect)
}

extension MainCoordinator: MainNavigationDelegate {
    func showDetailPage(criminal: CriminalItem, displayImageURLString: String, displayImageOriginFrame: CGRect) {
        let coordinator = DetailCoordinator(navigationController: navigationController,
                                            criminal: criminal,
                                            displayImageURLString: displayImageURLString,
                                            displayImageOriginFrame: displayImageOriginFrame)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

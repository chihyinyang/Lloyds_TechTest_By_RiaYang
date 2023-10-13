//
//  Coordinator.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

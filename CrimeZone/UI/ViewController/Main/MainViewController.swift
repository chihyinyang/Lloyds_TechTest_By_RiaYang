//
//  MainViewController.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import UIKit
import Shuffle
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var shuffleVC: ShuffleViewController = {
        let viewModel = ShuffleViewModel()
        let vc = ShuffleViewController(viewModel: viewModel)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    var viewModel: MainViewModel
    
    weak var navigation: MainNavigationDelegate?
        
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.setAccessibilityIdentifier(by: .mainViewController)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleState()
        handleAction()

        Task {
            let response = try await viewModel.requestResponse()
            await viewModel.requestFBIWanted(response: { response })
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 235, green: 235, blue: 235)
        addShuffleCardVCAsChild()
    }
    
    private func addShuffleCardVCAsChild() {
        addChild(shuffleVC)
        view.addSubview(shuffleVC.view)
        shuffleVC.view.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.height.equalTo(610)
            make.center.equalTo(view.snp.center)
        }
        shuffleVC.didMove(toParent: self)
    }
    
    private func handleState() {
        viewModel.$loadingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .idle:
                    break
                case .loading:
                    // handle while loading data
                    break
                case .loaded:
                    // update UI
                    self.shuffleVC.updateCards(criminals: self.viewModel.criminals)
                    
                case .failed(_):
                    // handle if request failure
                    break
                case .noInternet:
                    // handle if no internet
                    break
                }
            }.store(in: &viewModel.cancellables)
    }
    
    private func handleAction() {
        // show detail page
        shuffleVC.viewModel.showDetailPageByIndex
            .sink { [weak self] index in
                guard let self = self else { return }
                
                // get image current position to transition
                if self.viewModel.criminals.indices.contains(index),
                   let imageURLString = self.viewModel.criminals[index].images?.first?.large,
                   let index = self.shuffleVC.cardStack.topCardIndex,
                   let topCard = self.shuffleVC.cardStack.card(forIndexAt: index),
                   let imageView = (topCard.content as? ShuffleContentView)?.imageView {
                    
                    // conduct showing detail page action with needed data
                    self.navigation?.showDetailPage(criminal: self.viewModel.criminals[index],
                                                    displayImageURLString: imageURLString,
                                                    displayImageOriginFrame: imageView.convert(imageView.bounds, to: self.view))
                }
            }.store(in: &viewModel.cancellables)
    }
}


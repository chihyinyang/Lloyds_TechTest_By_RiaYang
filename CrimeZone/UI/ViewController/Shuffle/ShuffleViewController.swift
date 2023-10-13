//
//  ShuffleViewController.swift
//  CrimeZone
//
//  Created by 楊智茵 on 07/10/2023.
//

import UIKit
import Shuffle
import SnapKit
import Combine

class ShuffleViewController: UIViewController {
            
    lazy var cardStack: SwipeCardStack = {
        let cardStack = SwipeCardStack()
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        cardStack.dataSource = self
        return cardStack
    }()
    
    let viewModel: ShuffleViewModel
    
    init(viewModel: ShuffleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI
    private func setupUI() {
        addShuffleCardUI()
    }
    
    private func addShuffleCardUI() {
        view.addSubview(cardStack)
        cardStack.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    // MARK: - data
    func updateCards(criminals: [CriminalItem]) {
        viewModel.criminals = criminals
        cardStack.reloadData()
    }
}

// MARK: - shuffle dataSource
extension ShuffleViewController: SwipeCardStackDataSource {
    private func createCard(fromImageURLString urlString: String, index: Int) -> SwipeCard {
        let card = SwipeCard()
        card.swipeDirections = [.left, .right]
                
        let cardContent = ShuffleContentView()
        
        // setup data of the content view
        cardContent.setupData(urlString: urlString, index: index)
        
        // setup views identifier for testing
        cardContent.setupAccessibilityIdentifier(by: index)
        
        // handle arrow button action -> show detail page
        cardContent.showDetailPageByIndex = viewModel.showDetailPageByIndex
        card.content = cardContent
        return card
    }
    
    func cardStack(_ cardStack: Shuffle.SwipeCardStack, cardForIndexAt index: Int) -> Shuffle.SwipeCard {
        let imageURLString = viewModel.getImageURLStringIfContainsIndex(at: index)
        return createCard(fromImageURLString: imageURLString, index: index)
    }
    
    func numberOfCards(in cardStack: Shuffle.SwipeCardStack) -> Int {
        return viewModel.criminals.count
    }
}

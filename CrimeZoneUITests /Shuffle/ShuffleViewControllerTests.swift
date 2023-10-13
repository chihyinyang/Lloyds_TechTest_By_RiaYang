//
//  ShuffleViewControllerTests.swift
//  CrimeZoneUITests
//
//  Created by 楊智茵 on 10/10/2023.
//

import XCTest
import SDWebImage
@testable import CrimeZone

final class ShuffleViewControllerTests: XCTestCase {
    
    var app = XCUIApplication()
    
    override func setUp() async throws {
        try await super.setUp()
        DispatchQueue.main.async {
            self.app = XCUIApplication()
            self.app.launch()
        }
    }

    override func tearDown() async throws {
        try await super.tearDown()
    }
    
    func test_shuffleArrowButton_onTap() {
       let shuffleArrowButtonID = IdentifierConstant.shuffleArrowButton(index: 0).getIdentifier()
        let shuffleArrowButton = app.buttons[shuffleArrowButtonID]
                
        shuffleArrowButton.tap()
              
        let detailViewControllerID = IdentifierConstant.detailViewController.getIdentifier()
        let detailViewController = app.otherElements[detailViewControllerID]
        XCTAssertTrue(detailViewController.exists, "Failed to navigate to DetailViewController")
    }
    
    func test_shuffleContentView_swipeGesture() {
        let dragDistance: CGFloat = 500
        let swipeLeftActions = Array(repeating: -dragDistance, count: 3)
        let swipeRightActions = Array(repeating: dragDistance, count: 3)
        let randomActions = (swipeLeftActions + swipeRightActions).shuffled()
        
        for (index, distanceX) in randomActions.enumerated() {
            let shuffleContentViewIdentifier = IdentifierConstant.shuffleContentView(index: index).getIdentifier()
            let shuffleContentView = app.otherElements[shuffleContentViewIdentifier]
            
            let startPoint = shuffleContentView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            
            startPoint.press(forDuration: 0.01, thenDragTo: startPoint.withOffset(CGVector(dx: distanceX, dy: 0)))
        }
    }
}

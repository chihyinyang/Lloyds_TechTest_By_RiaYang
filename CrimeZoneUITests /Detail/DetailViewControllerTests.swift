//
//  DetailViewControllerTests.swift
//  CrimeZoneUITests
//
//  Created by 楊智茵 on 10/10/2023.
//

import SDWebImage
import XCTest
@testable import CrimeZone

final class DetailViewControllerTests: XCTestCase {

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
    
    func whenDetailViewControllerShown() {
        let shuffleArrowButtonID = IdentifierConstant.shuffleArrowButton(index: 0).getIdentifier()
        let shuffleArrowButton = app.buttons[shuffleArrowButtonID]
                
        shuffleArrowButton.tap()
              
        let detailViewControllerID = IdentifierConstant.detailViewController.getIdentifier()
        let detailViewController = app.otherElements[detailViewControllerID]
        XCTAssertTrue(detailViewController.exists, "Failed to navigate to DetailViewController")
    }
    
    func test_detailArrowButton_onTap() {
        // when
        whenDetailViewControllerShown()
        // setup
        let detailArrowButtonID = IdentifierConstant.detailArrowButton.getIdentifier()
        let detailArrowButton = app.buttons[detailArrowButtonID]
                
        detailArrowButton.tap()
              
        let mainViewControllerID = IdentifierConstant.mainViewController.getIdentifier()
        let mainViewController = app.otherElements[mainViewControllerID]
        XCTAssertTrue(mainViewController.exists, "Failed to dismiss to MainViewController")
    }
}

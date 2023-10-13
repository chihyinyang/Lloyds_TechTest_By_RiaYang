//
//  DetailViewModelTests.swift
//  CrimeZoneTests
//
//  Created by 楊智茵 on 10/10/2023.
//

import XCTest
import SDWebImage
@testable import CrimeZone

final class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        
    }
    
    override func tearDown() async throws {
        sut = nil
        try await super.tearDown()
    }
    
    func test_convertCriminalDataIntoDisplayData() {
        let fakeCriminalData = CriminalItem(hair: "brown",
                                            eyes: "blue",
                                            title: "Johnson",
                                            remarks: "Johnson is previously known to live in Stone Mountain, Georgia.",
                                            sex: "male",
                                            height: 180,
                                            weight: 45,
                                            age: 56,
                                            occupations: ["Surgical Catheter Technician",
                                                          "Respiratory Therapist",
                                                          "Fireman"],
                                            dateOfBirth: ["02/02/1987"],
                                            placeOfBirth: "Brooklyn, New York",
                                            warningMessage: "SHOULD BE CONSIDERED ARMED AND DANGEROUS",
                                            caution: "Robert William Fisher is wanted for allegedly killing his wife and two young children and then blowing up the house in which they all lived in Scottsdale, Arizona, in April of 2001.",
                                            images: [])
        sut = DetailViewModel(criminal: fakeCriminalData,
                              displayImageURLString: "",
                              displayImageOriginFrame: .zero)
        
        let expect = [DetailDisplayData(key: "Hair", value: "brown"),
                      DetailDisplayData(key: "Eyes", value: "blue"),
                      DetailDisplayData(key: "Remarks", value: "Johnson is previously known to live in Stone Mountain, Georgia."),
                      DetailDisplayData(key: "Sex", value: "male"),
                      DetailDisplayData(key: "Height", value: "180"),
                      DetailDisplayData(key: "Weight", value: "45"),
                      DetailDisplayData(key: "Age", value: "56"),
                      DetailDisplayData(key: "Date of Birth", value: "02/02/1987"),
                      DetailDisplayData(key: "Place of Birth", value: "Brooklyn, New York"),
                      DetailDisplayData(key: "Occupation", value: "Surgical Catheter Technician, Respiratory Therapist, Fireman"),
                      DetailDisplayData(key: "Warning", value: "SHOULD BE CONSIDERED ARMED AND DANGEROUS"),
                      DetailDisplayData(key: "Caution", value: "Robert William Fisher is wanted for allegedly killing his wife and two young children and then blowing up the house in which they all lived in Scottsdale, Arizona, in April of 2001.")]
        XCTAssertEqual(sut.displayRow, expect, "DetailViewModel-DisplayRow data convert failure")
    }
}

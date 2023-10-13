//
//  MainViewModelTests.swift
//  CrimeZoneTests
//
//  Created by 楊智茵 on 07/10/2023.
//

import SDWebImage
import XCTest
@testable import CrimeZone

final class MainViewModelTests: XCTestCase {
    
    var sut: MainViewModel!
    var networkService: NetworkService!
    var parser: DataParser!
    var responseService: EndpointResponseServiceProtocol!

    override func setUp() async throws {
        try? await super.setUp()
    }

    override func tearDown() async throws {
        sut = nil
        networkService = nil
        parser = nil
        responseService = nil
        try? await super.tearDown()
    }
    
    // MARK: - when
    func setupService() {
        networkService = NetworkService()
        parser = DataParser()
        responseService = EndpointResponseService(networkService: networkService, parser: parser)
        sut = MainViewModel(responseService: responseService, connectionManager: ConnectionManager())
    }
    
    func getCriminalDataFileUrl() -> URL? {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "CriminalData", withExtension: "json")
        return fileUrl
    }
    
    func requestResponse(fileUrl: URL) async throws -> CriminalData {
        return try responseService.decodeMockData(fromJSON: fileUrl)
    }
    
    func when_fetching_criminalList() async throws {
        setupService()
        let fileUrl = getCriminalDataFileUrl()
        let response = try await requestResponse(fileUrl: fileUrl!)
        await sut.requestFBIWanted(response: { response })
    }
    
    // MARK: - tests
    func test_fetch_criminalList_state() async {
        do {
            // when
            try await when_fetching_criminalList()
            // loadingState
            XCTAssertEqual(sut.loadingState, .loaded, "Loading state error")
        } catch {
            XCTFail("Testing fetch criminalList state fail with: \(error)")
        }
    }
    
    func test_fetch_criminalList_data() async {
        do {
            // when
            try await when_fetching_criminalList()
            
            // url file
            let fileUrl = getCriminalDataFileUrl()
            let data = try Data(contentsOf: fileUrl!)
            let criminalData: CriminalData = try parser.parse(data: data)

            XCTAssertEqual(sut.criminals, criminalData.items, "Received criminal data error")
        } catch {
            XCTFail("Testing fetch criminalList data fail with: \(error)")
        }
    }
}

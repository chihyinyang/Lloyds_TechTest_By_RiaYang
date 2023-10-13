//
//  EndpointResponseMessage.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation

protocol EndpointResponseServiceProtocol {
    func decodeData<T: Codable>(from endpoint: Endpoint) async throws -> T
    func decodeMockData<T: Codable>(fromJSON url: URL) throws -> T
}

struct EndpointResponseService: EndpointResponseServiceProtocol {
    let networkService: NetworkServiceProtocol
    let parser: DataParserProtocol
    
    init(networkService: NetworkServiceProtocol, parser: DataParserProtocol) {
        self.networkService = networkService
        self.parser = parser
    }
    
    func decodeData<T: Codable>(from endpoint: Endpoint) async throws -> T {
        let data = try await networkService.requestData(with: endpoint)
        let decodedData: T = try parser.parse(data: data)
        return decodedData
    }
    
    func decodeMockData<T: Codable>(fromJSON url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)
            let decodedData: T = try parser.parse(data: data)
            return decodedData
        } catch {
            throw error
        }
    }
}

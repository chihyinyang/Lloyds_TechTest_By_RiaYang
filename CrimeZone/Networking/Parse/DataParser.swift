//
//  DataParser.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Codable>(data: Data) throws -> T
}

struct DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parse<T: Codable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

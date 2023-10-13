//
//  NetworkError.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidServerResponse
    case invalidURL
    case unknownApi
    case offline
}

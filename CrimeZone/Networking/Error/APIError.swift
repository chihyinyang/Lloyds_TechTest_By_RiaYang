//
//  APIError.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation

struct ApiError: Codable, Error {
    var name: String?
    var code: Int?
    var error: String?
}

extension ApiError {
    func errorMessage() -> String {
        guard let message = error else { return ApiError.getErrorResponseMessage(with: code ?? 999) }
        return message
    }
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        return errorMessage()
    }
}

extension ApiError {
    static func getErrorResponseMessage(with statusCode: Int) -> String {
        let errorResponseMessage = ErrorResponseMessage(rawValue: statusCode) ?? .unknownError
        return errorResponseMessage.message
    }
}

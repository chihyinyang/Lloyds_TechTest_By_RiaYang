//
//  Endpoint.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation

protocol Endpoint {
    var scheme: URLScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [URLQueryItem] { get }
    var methodType: HTTPMethodType { get }
    var bearerToken: String? { get }
    var httpBody: Data? { get }
}

extension Endpoint {
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.path = baseURL + path
        components.queryItems = parameters
        
        guard let url = components.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        
        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
        }
        urlRequest.httpMethod = methodType.rawValue
        urlRequest.httpBody = httpBody
        
        return urlRequest
    }
}

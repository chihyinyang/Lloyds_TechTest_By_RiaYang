//
//  FBIWantedEndpoints.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation

enum FBIWantedEndpoints: Endpoint {
    case getList
    
    var scheme: URLScheme {
        switch self {
        default:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return BaseURL.localHost.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/list"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var headers: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    var methodType: HTTPMethodType {
        switch self {
        default:
            return .GET
        }
    }
    
    var bearerToken: String? {
        switch self {
        default:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        default:
            return nil
        }
    }
}

//
//  CriminalDataStruct.swift
//  CrimeZone
//
//  Created by 楊智茵 on 06/10/2023.
//

import Foundation

struct CriminalData: Codable {
    let items: [CriminalItem]?
}

struct CriminalItem: Codable, Equatable {
    let hair: String?
    let eyes: String?
    let title: String?
    let remarks: String?
    let sex: String?
    let height: Int?
    let weight: Int?
    let age: Int?
    let occupations: [String]?
    let dateOfBirth: [String]?
    let placeOfBirth: String?
    let warningMessage: String?
    let caution: String?
    let images: [CriminalImage]?
    
    enum CodingKeys: String, CodingKey {
        case hair = "hair_raw"
        case eyes = "eyes_raw"
        case title = "title"
        case remarks = "remarks"
        case sex = "sex"
        case height = "height_max"
        case weight = "weight_max"
        case age = "age_min"
        case occupations = "occupations"
        case dateOfBirth = "date_of_birth"
        case placeOfBirth = "place_of_birth"
        case warningMessage = "warning_message"
        case caution = "caution"
        case images = "images"
    }
}

struct CriminalImage: Codable, Equatable {
    let thumb: String?
    let large: String?
    let caption: String?
}

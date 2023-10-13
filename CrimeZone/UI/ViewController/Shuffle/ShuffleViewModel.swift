//
//  ShuffleViewModel.swift
//  CrimeZone
//
//  Created by 楊智茵 on 10/10/2023.
//

import Combine

class ShuffleViewModel {
    
    var criminals: [CriminalItem] = []
    
    var showDetailPageByIndex = PassthroughSubject<Int, Never>()
    
    func getImageURLStringIfContainsIndex(at index: Int) -> String {
        var imageURLString = ""
        if criminals.indices.contains(index) {
            imageURLString = criminals[index].images?.first?.large ?? ""
        }
        return imageURLString
    }
    
}

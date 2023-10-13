//
//  DetailViewModel.swift
//  CrimeZone
//
//  Created by 楊智茵 on 09/10/2023.
//

import UIKit
import Combine

class DetailViewModel {
    
    var criminal: CriminalItem
    
    var displayImageURLString: String
    
    var displayImageOriginFrame: CGRect
    
    var displayRow: [DetailDisplayData] = []
        
    var cancellables = Set<AnyCancellable>()
        
    init(criminal: CriminalItem, displayImageURLString: String, displayImageOriginFrame: CGRect) {
        self.criminal = criminal
        self.displayImageURLString = displayImageURLString
        self.displayImageOriginFrame = displayImageOriginFrame
        convertCriminalDataIntoDisplayData()
    }
    
    func convertCriminalDataIntoDisplayData() {
        if let hair = criminal.hair {
            displayRow.append(DetailDisplayData(key: "Hair", value: hair))
        }
        
        if let eyes = criminal.eyes {
            displayRow.append(DetailDisplayData(key: "Eyes", value: eyes))
        }
        
        if let remarks = criminal.remarks {
            displayRow.append(DetailDisplayData(key: "Remarks", value: remarks))
        }
        
        if let sex = criminal.sex {
            displayRow.append(DetailDisplayData(key: "Sex", value: sex))
        }
        
        if let height = criminal.height {
            displayRow.append(DetailDisplayData(key: "Height", value: "\(height)"))
        }
        
        if let weight = criminal.weight {
            displayRow.append(DetailDisplayData(key: "Weight", value: "\(weight)"))
        }
        
        if let age = criminal.age {
            displayRow.append(DetailDisplayData(key: "Age", value: "\(age)"))
        }
        
        if let dateOfBirth = criminal.dateOfBirth?.first {
            displayRow.append(DetailDisplayData(key: "Date of Birth", value: dateOfBirth))
        }
        
        if let placeOfBirth = criminal.placeOfBirth {
            displayRow.append(DetailDisplayData(key: "Place of Birth", value: placeOfBirth))
        }
        
        if let occupation = criminal.occupations {
            displayRow.append(DetailDisplayData(key: "Occupation", value: occupation.joined(separator: ", ")))
        }
        
        if let warning = criminal.warningMessage {
            displayRow.append(DetailDisplayData(key: "Warning", value: warning))
        }
        
        if let caution = criminal.caution {
            displayRow.append(DetailDisplayData(key: "Caution", value: caution))
        }
        
        if displayRow.isEmpty {
            displayRow.append(DetailDisplayData(key: "No Data", value: ""))
        }
    }
    
    func getDisplayDataIfContainsIndex(at index: Int) -> DetailDisplayData? {
        if displayRow.indices.contains(index) {
             return displayRow[index]
        } else {
            return nil
        }
    }
}

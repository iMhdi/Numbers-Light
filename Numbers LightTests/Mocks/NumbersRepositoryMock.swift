//
//  NumbersRepositoryMock.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

@testable import Numbers_Light

class NumbersRepositoryMock: NumbersRepositoryProtocol {
    
    var allNumbers: Numbers?
    func fetchNumbersList(withCompletion completion: @escaping (Numbers?) -> Void) {
        completion(allNumbers)
    }
    
    var wantedNumber: NumberBO?
    func fetchNumber(withName name: String, andCompletion completion: @escaping (NumberBO?) -> Void) {
        completion(wantedNumber)
    }
}

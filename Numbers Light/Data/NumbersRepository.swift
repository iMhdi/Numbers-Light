//
//  NumbersRepository.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

import Foundation

protocol NumbersRepositoryProtocol {
    func fetchNumbersList(withCompletion completion: @escaping (Numbers?) -> Void)
    func fetchNumber(withName name: String, andCompletion completion: @escaping (NumberBO?) -> Void)
}

class NumbersRepository {
    
}

extension NumbersRepository: NumbersRepositoryProtocol {
    
    func fetchNumbersList(withCompletion completion: @escaping (Numbers?) -> Void) {
        APIRouter.Numbers.numbers.execute(withCompletionHandler: { (result: Result<Numbers, Error>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            case .success(let numbers):
                print("Count : \(numbers.count) numbers")
                completion(numbers)
            }
        })
    }
    
    func fetchNumber(withName name: String, andCompletion completion: @escaping (NumberBO?) -> Void) {
        APIRouter.Numbers.number(name: name).execute(withCompletionHandler: { (result: Result<NumberBO, Error>) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            case .success(let number):
                completion(number)
            }
        })
    }
}

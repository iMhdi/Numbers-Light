//
//  DetailsViewModel.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import UIKit

protocol DetailsViewModelProtocol: AnyObject {
    func getSelectedNumber() -> NumberBO?
}

class DetailsViewModel {
  
    // MARK: - Public variables
  
    // MARK: - Private variables
    var selectedNumber: NumberBO?
  
    // MARK: - Initialization
    init (selectedNumber: NumberBO?) {
        self.selectedNumber = selectedNumber
    }
}

extension DetailsViewModel: DetailsViewModelProtocol {
    func getSelectedNumber() -> NumberBO? {
        return selectedNumber
    }
}

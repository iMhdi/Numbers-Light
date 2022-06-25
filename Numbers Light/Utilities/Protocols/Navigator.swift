//
//  Navigator.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import Foundation

protocol Navigator {
    func navigate(to destination: Destination, withStyle presentationStyle: ViewControllerPresentationStyle, andData dataDictionary:[String:Any?]?)
}

//
//  ControllerFactory.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

import UIKit

class ControllerFactory {
    
    static func newInstance(for destination: Destination, withContainer container: DIContainer, andData dataDictionary:[String:Any?]? = nil) -> UIViewController {
        switch destination {
        case .home:
            return container.defaultContainer.resolve(HomeViewController.self)!
        case .details:
            let selectedNumber = dataDictionary!["selectedNumber"] as? NumberBO
            let detailsController = container.defaultContainer.resolve(DetailsViewController.self, argument: selectedNumber)!
            return detailsController
        }
    }
}

//
//  AppDIContainer.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import Swinject

class DIContainer {
    let defaultContainer = Container()
    
    func registerDependencies() {
        defaultContainer.register(HomeViewController.self) { resolver in
            return HomeViewController(viewModel: resolver.resolve(HomeViewModel.self)!)
        }
        
        defaultContainer.register(HomeViewModel.self) { (resolver) in
            return HomeViewModel(useCases: resolver.resolve(HomeUseCases.self)!)
        }
        
        defaultContainer.register(HomeUseCases.self) { resolver in
            return HomeUseCases(numbersRepository: resolver.resolve(NumbersRepository.self)!)
        }
        
        defaultContainer.register(NumbersRepository.self) { _ in
            return NumbersRepository()
        }
        
        defaultContainer.register(DetailsViewController.self) { (resolver, selectedNumber: NumberBO?) in
            return DetailsViewController(viewModel: resolver.resolve(DetailsViewModel.self, argument: selectedNumber)!)
        }
        
        defaultContainer.register(DetailsViewModel.self) { (resolver, selectedNumber: NumberBO?) in
            return DetailsViewModel(selectedNumber: selectedNumber)
        }
    }
}

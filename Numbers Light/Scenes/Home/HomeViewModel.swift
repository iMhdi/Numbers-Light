//
//  HomeViewModel.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import UIKit

protocol HomeViewModelProtocol {
    func bindToView(view: HomeViewProtocol)
    
    func loadNumbersList()
    func getNumbersList() -> Numbers?
    func getNumberDetails(withName name: String)
    
    func startMonitoringNetworkChanges()
    func stopMonitoringNetworkChanges()
}

class HomeViewModel {
  
    // MARK: - Public variables
    weak var view: HomeViewProtocol?
  
    // MARK: - Private variables
    private var useCases: HomeUseCasesProtocol?
    private var numbersList: Numbers?
  
    // MARK: - Initialization
    init (useCases: HomeUseCasesProtocol) {
        self.useCases = useCases
    }
    
    func bindToView(view: HomeViewProtocol) {
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func getNumbersList() -> Numbers? {
        return numbersList
    }
    
    func loadNumbersList() {
        useCases?.executeGetNumbersList(withCompletion: { [weak self] numbers in
            if let numbers = numbers {
                self?.numbersList = numbers
                self?.view?.didLoadNumbersList(list: numbers)
            } else {
                self?.numbersList = nil
                self?.view?.didFailToLoadNumbersList(withError: nil)
            }
        })
    }
    
    func getNumberDetails(withName name: String) {
        useCases?.executeGetNumberDetails(withName: name, andCompletion: { [weak self] number in
            if let number = number {
                self?.view?.didLoadNumberDetails(number: number)
            } else {
                self?.view?.didFailToLoadNumberDetails(withError: nil)
            }
        })
    }
    
    func startMonitoringNetworkChanges() {
        observeConnectivityChanges()
        useCases?.executeStartMonitoringNetworkChanges()
    }

    func stopMonitoringNetworkChanges() {
        useCases?.executeStopMonitoringNetworkChanges()
    }
    
    func observeConnectivityChanges() {
        useCases?.executeObserveConnectivityChanges(on: self, { [weak self] isConnected in
            if isConnected {
                if let shouldForceRefresh = self?.useCases?.executeShouldForceRefresh(ofList: self?.numbersList), shouldForceRefresh {
                    self?.view?.startLoading()
                    self?.loadNumbersList()
                }
            }
        })
    }
}

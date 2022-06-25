//
//  HomeUseCases.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

import UIKit
import Network

protocol HomeUseCasesProtocol {
    func executeStartMonitoringNetworkChanges()
    func executeStopMonitoringNetworkChanges()
    func executeObserveConnectivityChanges(on observer: AnyObject, _ observerBlock: @escaping (Bool) -> Void)

    func executeGetNumbersList(withCompletion completion: @escaping (Numbers?) -> Void)
    func executeGetNumberDetails(withName name: String, andCompletion completion: @escaping (NumberBO?) -> Void)
    
    func executeShouldForceRefresh(ofList list: Numbers?) -> Bool
}

final class HomeUseCases: HomeUseCasesProtocol {
    
    // MARK: - Private variables
    private let numbersRepository: NumbersRepositoryProtocol?
    var connectivityStatus: Observable<NWPath.Status?> = Observable<NWPath.Status?>(nil)
    let networkPathMonitor = NWPathMonitor()
  
    // MARK: - Initialization
    init(numbersRepository: NumbersRepositoryProtocol?) {
        self.numbersRepository = numbersRepository
    }

    // MARK: - Execute functions    
    func executeGetNumbersList(withCompletion completion: @escaping (Numbers?) -> Void) {
        numbersRepository?.fetchNumbersList(withCompletion: { numbers in
            completion(numbers)
        })
    }
    
    func executeGetNumberDetails(withName name: String, andCompletion completion: @escaping (NumberBO?) -> Void) {
        numbersRepository?.fetchNumber(withName: name, andCompletion: { number in
            completion(number)
        })
    }
    
    func executeStartMonitoringNetworkChanges() {
        networkPathMonitor.pathUpdateHandler = { [weak self] path in
            self?.connectivityStatus.value = path.status
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        networkPathMonitor.start(queue: queue)
    }
    
    func executeStopMonitoringNetworkChanges() {
        networkPathMonitor.cancel()
    }
    
    func executeObserveConnectivityChanges(on observer: AnyObject, _ observerBlock: @escaping (Bool) -> Void) {
        connectivityStatus.observe(on: self) { status in
            if let status = status {
                var isConnected: Bool
                if status == .satisfied {
                    isConnected = true
                } else {
                    isConnected = false
                }
                
                DispatchQueue.main.async {
                    observerBlock(isConnected)
                }
            }
        }
    }
    
    func executeShouldForceRefresh(ofList list: Numbers?) -> Bool {
        if list == nil || list!.count == 0 {
            return true
        }
        
        return false
    }
}

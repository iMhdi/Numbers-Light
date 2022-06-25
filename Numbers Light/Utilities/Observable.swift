//
//  Observable.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import Foundation

public final class Observable<Value> {
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
        let errorBlock: ((Error?) -> Void)?
    }
    
    private var observers = [Observer<Value>]()
    
    public var value: Value {
        didSet { notifyObservers() }
    }

    public var error: Error? {
        didSet { notifyObserversOnError() }
    }
    
    public init(_ value: Value) {
        self.value = value
    }

    public func observe(on observer: AnyObject, _ observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock, errorBlock: nil))
        observerBlock(self.value)
    }

    public func observe(on observer: AnyObject, _ observerBlock: @escaping (Value) -> Void, onError: ((Error?) -> Void)? = nil) {
        observers.append(Observer(observer: observer, block: observerBlock, errorBlock: onError))
        observerBlock(self.value)
    }
    
    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer && $0.observer != nil}
    }
    
    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async { observer.block(self.value) }
        }
    }

    private func notifyObserversOnError() {
        for observer in observers {
            DispatchQueue.main.async { observer.errorBlock?(self.error) }
        }
    }
}

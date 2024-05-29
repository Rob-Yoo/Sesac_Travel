//
//  Observable.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import Foundation

enum ObservableEvent<Value> {
    case next(Value)
    case error(Error)
    case completed
}

final class Observable<Value> {
    private var observers = [Observer<Value>]()
    
    var value: Value {
         didSet { notifyObservers(event: .next(value)) }
     }
    
    
    init(_ value: Value) {
        self.value = value
    }
    
    deinit {
        observers.removeAll()
    }
    
    @discardableResult
    func observe(
        on observer: AnyObject,
        observerBlock: @escaping (ObservableEvent<Value>) -> Void
    ) -> Self {

        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(.next(self.value))
        
        return self
    }
    
    private func notifyObservers(event: ObservableEvent<Value>) {
        for observer in observers {
            observer.block(event)
        }
    }
    
    func removeDisposable(for observer: AnyObject) -> () -> Void {
        return { [weak self] in
            self?.remove(observer: observer)
        }
    }

    private func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    @discardableResult
    func subscribe(
        on observer: AnyObject,
        disposeBag: DisposeBag,
        onNext: ((Value) -> Void)? = nil,
        onError: ((Error) -> Void)? = nil,
        onCompleted: (() -> Void)? = nil
    ) -> Subscription<Value> {
        return Subscription(
            observable: self,
            observer: observer,
            disposeBag: disposeBag,
            onNext: onNext,
            onError: onError,
            onCompleted: onCompleted
        )
    }
}

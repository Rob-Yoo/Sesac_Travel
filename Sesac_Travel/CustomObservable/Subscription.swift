//
//  Subscription.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import Foundation

final class Subscription<Value> {
    private let observable: Observable<Value>
    private weak var observer: AnyObject?
    private let disposeBag: DisposeBag

    init(
           observable: Observable<Value>,
           observer: AnyObject,
           disposeBag: DisposeBag,
           onNext: ((Value) -> Void)? = nil,
           onError: ((Error) -> Void)? = nil,
           onCompleted: (() -> Void)? = nil
    ) {
        self.observable = observable
        self.observer = observer
        self.disposeBag = disposeBag
        
        if let onNext = onNext {
            self.onNext(onNext)
        }
        
        if let onError = onError {
            self.onError(onError)
        }
        
        if let onCompleted = onCompleted {
            self.onCompleted(onCompleted)
        }
    }

    @discardableResult
    func onNext(_ onNext: @escaping (Value) -> Void) -> Self {
        guard let observer = self.observer else { return self }
        
        let disposable = self.observable.observe(on: observer) { event in
            if case .next(let value) = event {
                onNext(value)
            }
        }.removeDisposable(for: observer)
        
        self.disposeBag.add(disposable)
        return self
    }
    
    @discardableResult
     func onError(_ onError: @escaping (Error) -> Void) -> Self {
         guard let observer = self.observer else { return self }

         let disposable = self.observable.observe(on: observer) { event in
             if case .error(let error) = event {
                 onError(error)
             }
         }.removeDisposable(for: observer)
         
         self.disposeBag.add(disposable)
         return self
     }
     
     @discardableResult
     func onCompleted(_ onCompleted: @escaping () -> Void) -> Self {
         guard let observer = self.observer else { return self }

         let disposable = self.observable.observe(on: observer) { event in
             if case .completed = event {
                 onCompleted()
             }
         }.removeDisposable(for: observer)

         self.disposeBag.add(disposable)
         return self
     }
}

//
//  DisposableBag.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import Foundation

private final class Disposables {
    private var disposables: [() -> Void] = []
    
    func add(_ disposable: @escaping () -> Void) {
        self.disposables.append(disposable)
    }
    
    func dispose() {
        self.disposables.forEach { $0() }
        self.disposables.removeAll()
    }
}

final class DisposeBag {
    private let disposables = Disposables()
    
    func add(_ disposable: @escaping () -> Void) {
        self.disposables.add(disposable)
    }
    
    func clear() {
        self.disposables.dispose()
    }
    
    deinit {
        self.disposables.dispose()
    }
}

//
//  Observer.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import Foundation

struct Observer<Value> {
    weak var observer: AnyObject?
    let block: (ObservableEvent<Value>) -> Void
}

//
//  Box.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 10.12.22.
//

import Foundation

final class Box<T> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    var value: T? {
        didSet {
            if let value {
                listener?(value)
            }
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        
        if let value {
            listener?(value)
        }
    }
}

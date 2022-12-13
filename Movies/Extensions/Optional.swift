//
//  Optional.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 13.12.22.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return (self ?? "").isEmpty
    }
}

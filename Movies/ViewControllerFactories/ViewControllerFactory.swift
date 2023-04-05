//
//  ViewControllerFactory.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 31.03.23.
//

import UIKit

protocol ViewControllerFactory {
    func makeViewController() -> UIViewController
}

//
//  UIViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 02.12.22.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
}

extension UIViewController {
    static func instantiate(fromStoryboard storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
}

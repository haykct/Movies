//
//  UIViewController.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 02.12.22.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum Storyboard: String {
        case main = "Main"
    }
    
    static func instantiate(fromStoryboard storyboard: Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        let identifier = String(describing: self)
        
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
}

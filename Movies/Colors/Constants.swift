//
//  Colors.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 11.12.22.
//

import UIKit
import SwiftUI

enum Constants {
    enum Colors {
        static let grey = UIColor(hexString: "#525151")
        static let cyan = UIColor(hexString: "#6ECCAD")
    }

    enum SwiftUIColors {
        static let grey = Color(red: 82 / 255, green: 81 / 255, blue: 81 / 255)
        static let cyan = Color(red: 110 / 255, green: 204 / 255, blue: 173 / 255)
        static let backgroundGrey = Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255)
        static let borderGrey = Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255)
        static let ratingYellow = Color(red: 255 / 255, green: 181 / 255, blue: 0 / 255)
    }
    
    enum Fonts {
        enum NunitoSans {
            static let regular = "NunitoSans-Regular"
            static let semiBold = "NunitoSans-SemiBold"
            static let bold = "NunitoSans-Bold"
            static let black = "NunitoSans-Black"
        }
    }
    
    enum Images {
        enum System {
            static let filledCircle = UIImage(systemName: "chevron.backward.circle.fill")
        }
    }
}

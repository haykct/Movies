//
//  SectionHeaderReusableView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 11.12.22.
//

import UIKit

final class SectionHeaderReusableView: UICollectionReusableView {
    
    //MARK: typealiases
    
    private typealias Colors = Constants.Colors
    
    //MARK: private properties
    
    private let titleTextLabel = UILabel()
    
    //MARK: lifecycle methods
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setupTitleLabel()
    }
    
    //MARK: public methods
    
    func setTitle(text: String) {
        titleTextLabel.text = text
    }
    
    //MARK: private methods
    
    private func setupTitleLabel() {
        titleTextLabel.frame = bounds
        titleTextLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleTextLabel.font = UIFont(name: Constants.Fonts.NunitoSans.bold, size: 22)
        titleTextLabel.textColor = Colors.grey
        addSubview(titleTextLabel)
    }
}

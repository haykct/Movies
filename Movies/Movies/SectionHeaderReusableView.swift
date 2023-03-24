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
        let fontName = Constants.Fonts.NunitoSans.bold
        let fontSize: CGFloat = 22
        
        titleTextLabel.frame = bounds
        titleTextLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleTextLabel.font = UIFont(name: fontName, size: fontSize)
        titleTextLabel.textColor = Colors.grey
        addSubview(titleTextLabel)
    }
}

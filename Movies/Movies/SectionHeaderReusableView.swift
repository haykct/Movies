//
//  SectionHeaderReusableView.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 11.12.22.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    
    //MARK: private properties
    
    private var titleTextLabel = UILabel()
    
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
        titleTextLabel.font = UIFont(name: "NunitoSans-Bold", size: 22)
        titleTextLabel.textColor = Colors.grey
        addSubview(titleTextLabel)
    }
}

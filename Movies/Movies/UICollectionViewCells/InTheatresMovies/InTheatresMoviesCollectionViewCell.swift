//
//  InTheatresMoviesCollectionViewCell.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 10.12.22.
//

import UIKit
import SDWebImage

final class InTheatresMoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: outlets
    
    @IBOutlet private weak var imageView: UIImageView!

    //MARK: lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = Constants.cellCornerRadius
    }
    
    //MARK: public methods
    
    func setupCell(withData data: InTheatresMovie, imageSize: CGSize) {
        loadImage(url: data.image, imageSize: imageSize)
    }
    
    //MARK: private methods
    
    private func loadImage(url: String, imageSize: CGSize) {
        let placeholderImage = Constants.Images.placeholder
        
        if let url = URL(string: url) {
            let transformer = SDImageResizingTransformer(size: imageSize, scaleMode: .aspectFill)
            
            imageView.sd_setImage(with: url, placeholderImage: placeholderImage, context: [.imageTransformer: transformer])
        } else {
            imageView.image = placeholderImage
        }
    }
}

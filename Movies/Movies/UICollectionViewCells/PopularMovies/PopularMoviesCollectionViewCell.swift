//
//  PopularMoviesCollectionViewCell.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import UIKit
import SDWebImage

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var ratingImageView: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    //MARK: lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = 12
    }
    
    //MARK: public methods
    
    func setupCell(withData data: PopularMovie, imageSize: CGSize) {
        ratingImageView.isHidden = data.rating.isEmpty
        ratingLabel.text = data.rating
        titleLabel.text = data.title
        loadImage(url: data.image, imageSize: imageSize)
    }
    
    //MARK: private methods
    
    private func loadImage(url: String, imageSize: CGSize) {
        if let url = URL(string: url) {
            let transformer = SDImageResizingTransformer(size: imageSize, scaleMode: .aspectFill)
            
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), context: [.imageTransformer: transformer])
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }

}

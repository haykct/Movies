//
//  PopularMoviesCollectionViewCell.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 12.12.22.
//

import UIKit
import Nuke

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
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
            let resizedImageProcessors = [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
            let options = ImageLoadingOptions(placeholder: UIImage(named: "placeholder"))
            let request = ImageRequest(url: url, processors: resizedImageProcessors)
            
            Nuke.loadImage(with: request, options: options, into: imageView)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }

}

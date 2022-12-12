//
//  InTheatresMoviesCollectionViewCell.swift
//  Movies
//
//  Created by Hayk Hayrapetyan on 10.12.22.
//

import UIKit
import Nuke

class InTheatresMoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: outlets
    
    @IBOutlet weak var imageView: UIImageView!

    //MARK: lifecycle methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = 12
    }
    
    //MARK: public methods
    
    func setupCell(withData data: InTheatresMovie, imageSize: CGSize) {
        loadImage(url: data.image, imageSize: imageSize)
    }
    
    //MARK: private methods
    
    private func loadImage(url: String, imageSize: CGSize) {
        //As images have low resolution we can uncomment this line for getting the original sized images
//        var url = url
//        if let dotRange = url.range(of: "._") {
//            url.replaceSubrange(dotRange.lowerBound..<url.endIndex, with: ".jpg")
//        }
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

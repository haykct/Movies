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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: public properties
    
    var hasTitle = false {
        willSet { titleLabel.isHidden = !newValue }
    }

    //MARK: lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 12
    }

    //MARK: public methods
    
    func setupCell(withData data: InTheatresMovie, imageSize: CGSize) {
        var poster = data.image
        
        //As images have low resolution we can uncomment this line for getting the original sized images
//        if let dotRange = data.image.range(of: "._") {
//            poster.replaceSubrange(dotRange.lowerBound..<poster.endIndex, with: ".jpg")
//        }
        
        if let url = URL(string: poster) {
            let resizedImageProcessors = [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
            let options = ImageLoadingOptions(placeholder: UIImage(named: "placeholder"))
            let request = ImageRequest(url: url, processors: resizedImageProcessors)
            
            Nuke.loadImage(with: request, options: options, into: imageView)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}

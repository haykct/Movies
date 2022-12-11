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
        
    }

    //MARK: public methods
    
    func setupCell(withData data: InTheatresMovie, imageSize: CGSize) {
        if let url = URL(string: data.image) {
            let deviceScale = window?.windowScene?.screen.scale ?? 1
            let imageSize = CGSize(width: frame.width * deviceScale, height: frame.height * deviceScale)
            let resizedImageProcessors = [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
            let options = ImageLoadingOptions(placeholder: UIImage(named: "placeholder"))
            let request = ImageRequest(url: url, processors: resizedImageProcessors)
            
            Nuke.loadImage(with: request, options: options, into: imageView)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}

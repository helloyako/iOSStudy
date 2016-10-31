//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by helloyako on 2016. 10. 31..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            activityIndicatorView.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            activityIndicatorView.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateWithImage(image: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWithImage(image: nil)
    }
    
}

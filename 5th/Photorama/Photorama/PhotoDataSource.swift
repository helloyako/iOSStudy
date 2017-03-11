//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by helloyako on 2016. 10. 31..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "UICollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        
        cell.updateWithImage(image: photo.image)
        
        
        return cell
    }

}

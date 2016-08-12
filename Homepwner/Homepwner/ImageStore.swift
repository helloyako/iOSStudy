//
//  ImageStore.swift
//  Homepwner
//
//  Created by helloyako on 2016. 8. 12..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.objectForKey(key) as? UIImage
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
    }
    
}
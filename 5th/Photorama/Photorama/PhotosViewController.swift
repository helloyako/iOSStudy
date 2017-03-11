//
//  PhotosViewController.swift
//  Photorama
//
//  Created by helloyako on 2016. 10. 27..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            
            OperationQueue.main.addOperation({
                switch photosResult {
                    case let .Success(photos):
                        print("Successfully found \(photos.count) recent photos.")
                        self.photoDataSource.photos = photos
                    case let .Failure(error):
                        self.photoDataSource.photos.removeAll()
                        print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                })
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            OperationQueue.main.addOperation({
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = NSIndexPath(row: photoIndex, section: 0) as IndexPath
                
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            })
        }
    }
    
}

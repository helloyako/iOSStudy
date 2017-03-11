//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by helloyako on 2016. 10. 31..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        store.fetchImageForPhoto(photo: photo){ (result) -> Void in
            switch result {
            case let .Success(image):
                OperationQueue.main.addOperation({
                    self.imageView.image = image
                    
                })
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

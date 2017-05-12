//
//  PinterestViewCell.swift
//  PinterestValley
//
//  Created by Emmanuel on 10/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import UIKit

class PinterestViewCell: UICollectionViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var cellUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    var pinterest: Pinterest? {
        didSet {
            
            if let currentPinterest = pinterest {
                nameLabel.text = currentPinterest.user.name
                idLabel.text = currentPinterest.id
//                avatarImage.image = currentPinterest.avatarLargeImage
//                coverImage.image = currentPinterest.coverSmallImage
                
            }
        }
    }
}
//
//let imageCache = NSCache<AnyObject, AnyObject>()
//
//extension UIImageView {
//    func loadImageUsingCacheWithUrl(urlString: String) {
//        self.image = nil
//        
//        // check for cache
//        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = cachedImage
//            return
//        }
//        
//        // download image from url
//        let url = URL(string: urlString)
//        let imageData = try? Data(contentsOf: url!)
//        
//        image = UIImage(data: imageData!)
//        
//        DispatchQueue.main.async(execute: { () -> Void in
//            imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
//            self.image = self.image
//        })
//    }
//}

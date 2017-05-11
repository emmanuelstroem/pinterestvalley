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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("awake from Nib Loaded . . . ")
        
    }
    
    var pinterest: Pinterest? {
        didSet {
            
            if let currentPinterest = pinterest {
                nameLabel.text = currentPinterest.user.name
                idLabel.text = currentPinterest.id
                
//            print("fullImage: \(currentPinterest.urls.full)")
                
            }
        }
    }
    

}

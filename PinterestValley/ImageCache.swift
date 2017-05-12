//
//  ImageCache.swift
//  PinterestValley
//
//  Created by Emmanuel on 12/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation

class ImageCache {
    
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in 
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "PinterestImageCache"
        cache.countLimit = 20 // Max 20 images in memory.
        cache.totalCostLimit = 50*1024*1024 // Max 10MB used.
        return cache
    }()

}

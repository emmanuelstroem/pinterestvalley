//
//  Pinterest.swift
//  PinterestValley
//
//  Created by Emmanuel on 06/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation
import UIKit

class Pinterest: NSObject {
    var id: String!
    var created_at: String!
    var width: Int!
    var height: Int!
    var colorCode: String!
    var likes: Int!
    var liked_by_user: Bool = false
    
    var user: User =  User()
    
    var urls: Urls = Urls()
    
    var category: [Category] = [Category()]
    
    var link: Link = Link()
    
    var coverSmallImage: UIImage!
    
    var avatarLargeImage: UIImage!
    
    
//    static let sharedInstance: Pinterest = {
//        let instance = Pinterest()
//        
//        return instance
//    }()
//    
//    override init() {
//        super.init()
//    }
}

class User: NSObject {
    var id: String!
    var username: String!
    var name: String!
    
    var profileImage: UserProfileImage = UserProfileImage()
    
    var links: UserLinks = UserLinks()
}

class UserProfileImage: NSObject {
    var small: String!
    var medium: String!
    var large: String!
    
}

class UserLinks: NSObject {
    var userLinkSelf: String!
    var userLinkHtml: String!
    var userLinkPhotos: String!
    var userLinkLikes: String!
}

class Urls: NSObject {
    var raw: String!
    var full: String!
    var regular: String!
    var small: String!
    var thumb: String!
}

class Category: NSObject {
    var id: Int!
    var title: String!
    var photo_count: Int!
    
    var links: CategoryLink = CategoryLink()
}

class CategoryLink: NSObject {
    var categoryLinkSelf: String!
    var categoryLinkPhotos: String!
}

class Link: NSObject {
    var link_self: String!
    var html: String!
    var download: String!
}

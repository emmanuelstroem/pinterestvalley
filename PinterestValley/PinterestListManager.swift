//
//  PinterestListManager.swift
//  Pinterest
//
//  Created by Emmanuel on 06/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation
import UIKit

class PinterestListManager: PinterestServiceManager {
    
    private var requestHandler: RequestHandler = RequestHandler()
    
    let pinterestDefault = UserDefaults.standard
    
    let requestbody: NSDictionary = [:]
    
    private var pinterestDataArray: [Pinterest]!
    
    private var isProcessing = false
    private var isDataAvailable = false
    
    func isPinterestFetchInProgress() -> Bool {
        return isProcessing
    }
    
    func isPinterestDataPresent() -> Bool {
        return isDataAvailable
    }
    
    func isPinterestPresentInPinterestArray(withPinterestId: String) -> Bool {
        var isPinterestPresent = false
        
        for singlePinterest: Pinterest in pinterestDataArray {
            if singlePinterest.id == withPinterestId {
                isPinterestPresent = true
            }
        }
        
        return isPinterestPresent
    }
    
    func getPinterestList() -> [Pinterest] {
        
        return PinterestPersistanceData.sharedInstance.getPinterestList()
    }
    
    func getSinglePinterest(index: Int) -> Pinterest? {
        
        return PinterestPersistanceData.sharedInstance.getSinglePinterest(index: index)
    }
    
    
    func getPinterests(finishBlock: @escaping (Bool) -> Void) {
        
        isProcessing = true
        
        var pinterestDataList = [Pinterest()]
        
//        var cache = NSCache<AnyObject, AnyObject>()
        
        requestHandler.getArray() {
            data, isSuccess in
            
            if isSuccess {
                
                if let responseArray = data {
                    
                    for arrayItem in responseArray as! [[String : AnyObject]] {
                        
//                        print("arrayItem: \(arrayItem["id"] as! String)")
                        
                        let pinterestItem: Pinterest = Pinterest()
                        
                        pinterestItem.id = arrayItem["id"] as! String
                        pinterestItem.created_at = arrayItem["created_at"] as! String
                        pinterestItem.width = arrayItem["width"] as! Int
                        pinterestItem.height = arrayItem["height"] as! Int
                        pinterestItem.colorCode = arrayItem["color"] as! String
                        pinterestItem.likes = arrayItem["likes"] as! Int
                        pinterestItem.liked_by_user = arrayItem["liked_by_user"] as! Bool
                        
                        let pinterestItemUser = pinterestItem.user
                        let pinterestItemUrl = pinterestItem.urls
                        var pinterestItemCategory = pinterestItem.category
                        let pinterestItemLink = pinterestItem.link
                        
                        
                        // User Dictionary
                        let arrayItemUser = arrayItem["user"] as! [String : AnyObject]
                        
                        pinterestItemUser.id = arrayItemUser["id"] as! String
                        pinterestItemUser.username = arrayItemUser["username"] as! String
                        pinterestItemUser.name = arrayItemUser["name"] as! String
                        
                        // user_profile_image
                        let userProfileImage = arrayItemUser["profile_image"] as! NSDictionary
                        
                        pinterestItemUser.profileImage.small = userProfileImage["small"] as! String
                        pinterestItemUser.profileImage.medium = userProfileImage["medium"] as! String
                        pinterestItemUser.profileImage.large = userProfileImage["large"] as! String
                        
                        
                        // user_links
                        let userLinks = arrayItemUser["links"] as! NSDictionary
                        
                        pinterestItemUser.links.userLinkSelf = userLinks["self"] as! String
                        pinterestItemUser.links.userLinkHtml = userLinks["html"] as! String
                        pinterestItemUser.links.userLinkPhotos = userLinks["photos"] as! String
                        pinterestItemUser.links.userLinkLikes = userLinks["likes"] as! String
                        
                        // URL Dictionary
                        let arrayItemUrl = arrayItem["urls"] as! [String : String]
                        
                        pinterestItemUrl.raw = arrayItemUrl["raw"]!
                        pinterestItemUrl.full = arrayItemUrl["full"]!
                        pinterestItemUrl.regular = arrayItemUrl["regular"]!
                        pinterestItemUrl.small = arrayItemUrl["small"]!
                        pinterestItemUrl.thumb = arrayItemUrl["thumb"]!
                        
                        
                        // Categories
                        let arrayItemCategory = arrayItem["categories"] as! NSArray
                        
                        for items in arrayItemCategory {
                            
                            let singlgePinterestItemCategory: Category = Category()
                            
                            let categoryItem = items as! [String : AnyObject]
                            
                            singlgePinterestItemCategory.id = categoryItem["id"] as! Int
                            singlgePinterestItemCategory.title = categoryItem["title"] as! String
                            singlgePinterestItemCategory.photo_count = categoryItem["photo_count"] as! Int
                            
                            // category >> links
                            let categoryLinks  = categoryItem["links"] as! NSDictionary
                            
                            let singleCategoryLink: CategoryLink = CategoryLink()
                            
                            singleCategoryLink.categoryLinkSelf = categoryLinks["self"] as! String
                            singleCategoryLink.categoryLinkPhotos = categoryLinks["photos"] as! String
                            
                            singlgePinterestItemCategory.links = singleCategoryLink
                            
                            pinterestItemCategory.append(singlgePinterestItemCategory)
                            
                        }
                        
                        // Links
                        let arrayItemLink = arrayItem["links"] as! [String : String]
                        
                        pinterestItemLink.link_self = arrayItemLink["self"]!
                        pinterestItemLink.html = arrayItemLink["html"]!
                        pinterestItemLink.download = arrayItemLink["download"]!
                        
                        
                        self.pinterestDataArray?.append(pinterestItem)
                        
                        pinterestDataList.append(pinterestItem)
                        
                        PinterestPersistanceData.sharedInstance.addPinterestToList(pinterestToAppend: pinterestItem)
                        
                        
                        
                    } //end for..in
                    
                    finishBlock(true)
                    
//                    for singlePinterest in pinterestDataList {
////                        print("got a pinterest: \(singlePinterest.urls.full)")
//                        if let fullImageUrl = singlePinterest.urls.full{
//                            print("got a pinterest: \(fullImageUrl)")
//                            
//                            HTTPStore().sendRequest(url: fullImageUrl, requestBody: [:] as NSDictionary){
//                                data, error, success in
//                                
//                                print(success)
//                                
//                                
//                            }
//                            
//                            self.getPinterestImage(imagePath: fullImageUrl){
//                                data, success in
//
//                                print("getting data..")
//                                if success {
//                                    
//                                }
//                            }
//                        }
//                    }
                    
//                    cache.setObject(pinterestDataList as AnyObject, forKey: "pintdata" as AnyObject)
                    
//                    let cacher = cache.object(forKey: "pintdata" as AnyObject)
                    
//                    print("UserDefaultDict", (cacher?[0] as AnyObject).user.name)
                    
//                    print("All Count: # : \(somedata)")
                    
                } //end response = data
                else {
                    
                    finishBlock(false)
                }
                
            }//end isSuccess
            
            finishBlock(false)
            
        } //end requestHandler
        
    }
    
    func getPinterestImage(imagePath: String, recievedImageBlock: @escaping (Data?, Bool) -> Void) {
        var imageData: Data?
        
        requestHandler.getImage(imageURL: imagePath){
            data, success in
            
            
            if success {
                
                imageData = data
                
                print("got IMAGE")
                
                recievedImageBlock(imageData, true)
            }
            else {
                recievedImageBlock(nil, false)
            }
        }
        
        recievedImageBlock(imageData, false)
        
    }
    
    
    //: ### Now lets define a function to convert our array to NSData
    
    func archivePinterest(pinterestList: [Pinterest]) -> NSData {
        let archivedPinterestObject = NSKeyedArchiver.archivedData(withRootObject: pinterestList as [Pinterest])
        return archivedPinterestObject as NSData
    }
    
}

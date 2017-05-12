//
//  RequestHandler.swift
//  Pinterest
//
//  Created by Emmanuel on 05/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation
import UIKit

class RequestHandler: HTTPStore {
    
    var constants: URLS?
    
    var pinterestsArray: [Pinterest]?
    
    let requestbody: NSDictionary = [:]
    
    var id: String = "1234"
    
    
    // MARK: Array Response
    func getArray(finishBlock: @escaping (NSArray?, Bool) -> Void) {
        
        constants = URLS()
        
        self.sendRequest(url: (constants?.apiURL)!, requestBody: requestbody){
            data, error, isSuccess in
            
            if isSuccess {
                print("HTTP Request was successful")
                
                if data != nil {
                    
                    let arrayData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                    
                    finishBlock(arrayData, true)
                }
                    
                else {
                    finishBlock(nil, false)
                }
            }
            else {
                finishBlock(nil, false)
            }
        }
    }
    
    
    //MARK: Data Reponse
    func getImage(imageURL: String, finishImageBlock: @escaping (Data?, Bool) -> Void) {
        var imageUIImage: Data?
        
        self.sendRequest(url: imageURL, requestBody: self.requestbody){
            data, error, isSuccess in
            
            if isSuccess {
                print("Image Request was successful")
                
                if data != nil {
                    //                    let imageData = UIImage(data: data!)
                    
                    imageUIImage = data
                    
                    finishImageBlock(imageUIImage, true)
                }
                    
                else {
                    finishImageBlock(nil, false)
                }
            }
            else {
                print("no image recieved")
                finishImageBlock(nil, false)
            }
        }
    }
    
    // MARK: JSON Response
    func getJson(finishBlock: @escaping (NSDictionary?, Bool) -> Void) {
        self.sendRequest(url: (constants?.jsonApiUrl)!, requestBody: requestbody){
            (data, error, isSuccess) in
            
            if isSuccess {
                if data != nil {
                    let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    
                    finishBlock(jsonData, true)
                }
            }
            else{
                
                finishBlock(nil, false)
            }
        }
    }
    
    // MARK: PDF Download or Response
    func getPDF(){
        
    }
    
    // MARK: XML Response
    func getXML() {
        
    }
    
}

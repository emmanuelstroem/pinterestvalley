//
//  RequestHandler.swift
//  Pinterest
//
//  Created by Emmanuel on 05/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation

class RequestHandler: HTTPStore {
    
    let constants: Constants = Constants()
    
    var pinterestsArray: [Pinterest]?
    
    let requestbody: NSDictionary = [:]
    
    var id: String = "1234"
    
    
    // MARK: Array Response
    func getArray(finishBlock: @escaping (NSArray?, Bool) -> Void) {
        
        self.sendRequest(url: constants.apiURL, requestBody: requestbody){
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
        self.sendRequest(url: imageURL, requestBody: requestbody){
            data, error, isSuccess in
            
            print("getImage() : ImageURL: \(imageURL)")
            
            if isSuccess{
                print("HTTP image request successful")
                
                if data != nil {
                    finishImageBlock(data, true)
                }
                else {
                    finishImageBlock(nil, false)
                }
            }
            else {
                finishImageBlock(nil, false)
            }
        }
    }
    
    // MARK: JSON Response
    func getJson(finishBlock: @escaping (NSDictionary?, Bool) -> Void) {
        self.sendRequest(url: constants.jsonApiUrl, requestBody: requestbody){
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

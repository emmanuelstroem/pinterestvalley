//
//  HTTPStore.swift
//  Pinterest
//
//  Created by Emmanuel on 02/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation

class HTTPStore {
    
    //default session
    var defaulSession = URLSession()
    
    //default session configuration
    var defaultConfiguration = URLSessionConfiguration()
    
    //inFlightDataTasks
    var inFlightDataTasks: NSMutableDictionary = [:]
    
    //Bool to abort sync
    var shouldAbortSync: Bool = false
    
    
    
    //MARK: Create Default Session Configuration
    func createDefaultSessionConfiguration(configType: URLSessionConfiguration?) -> URLSessionConfiguration {
        
        var sessionConfiguration: URLSessionConfiguration
        
        if configType == nil {
            sessionConfiguration = URLSessionConfiguration.default
        }
        else {
            sessionConfiguration = configType!
        }
        
        let additionalHTTPHeaders: [String: String] = ["Accept" : "application/json"]
        
        sessionConfiguration.httpAdditionalHeaders = additionalHTTPHeaders
        sessionConfiguration.allowsCellularAccess = true
        sessionConfiguration.timeoutIntervalForRequest = 180.0
        sessionConfiguration.timeoutIntervalForResource = 180.0
        
        self.defaultConfiguration = sessionConfiguration
        
        return sessionConfiguration
    }
    
    //MARK: Create Default Session
    func createDefaultSession(config: URLSessionConfiguration?, delegate: URLSessionDelegate?, queue: OperationQueue?) -> URLSession {
        
        let defaultSessionConfig = createDefaultSessionConfiguration(configType: config)
        
        return URLSession(configuration: defaultSessionConfig, delegate: delegate, delegateQueue: queue)
        
    }
    
    //MARK: Create Mutable Request for POST RequestBody
    func createMutableRequest(stringURL: String, requestBody: NSDictionary) -> NSMutableURLRequest {
        
        let sanitizedURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let postData = try! JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        
        let requestURL = URL(string: sanitizedURL!)
        
        let mutableURLRequest = NSMutableURLRequest(url: requestURL!)
        
        mutableURLRequest.httpMethod = "POST"
        mutableURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        mutableURLRequest.httpBody = postData
        
        return mutableURLRequest
        
    }
    
    //MARK: Making Data Request
    func sendRequest(url: String, requestBody: NSDictionary, completionBlock: @escaping (Data?, Error?, Bool) -> ()) {
        let session = createDefaultSession(config: nil, delegate: nil, queue: nil)
        
        let mutableRequest = createMutableRequest(stringURL: url, requestBody: requestBody)
        
        // make data task
        let dataTask = session.dataTask(with: mutableRequest as URLRequest) {
            (data, response, error) in
            
            // check for request errors
            if error == nil {
                
                // check for response codes
                if response != nil {
                    let response = response as! HTTPURLResponse
                    
                    if response.statusCode >= 200 && response.statusCode < 400 {
                        
                        // check for absence of data
                        if data != nil {
                            
                            completionBlock(data, nil, true)
                        }
                        else {
                            print("HTTPStore: sendRequest() => no error, response is OK, no data recieved")
                            
                            completionBlock(nil, nil, false)
                        }
                    }
                    else {
                        print("HTTPStore: sendRequest() => response != 200")
                    }
                    
                }
                else {
                    print("HTTPStore: sendRequest() => no error, but response is nil")
                    
                    completionBlock(nil, nil, false)
                }
                
            }
            else {
                
                print("HTTPStore: sendRequest() => error making http request: \(String(describing: error?.localizedDescription))")
                
                completionBlock(nil, error, false)
            }
        }
        
        dataTask.resume()
    }
    
    //MARK: Abort Requests
    func abortSync() {
        self.shouldAbortSync = true
        
        //loop through inFlightDataTasks and Cancel
        for everyDataTask in self.inFlightDataTasks.allValues {
            let singleInFlightDataTask = everyDataTask as! URLSessionDataTask
            
            print("HTTPStore: abortSync() => aborting request: \(singleInFlightDataTask)")
            
            singleInFlightDataTask.cancel()
        }
    }
    
    
}


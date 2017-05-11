//
//  PinterestValleyTests.swift
//  PinterestValleyTests
//
//  Created by Emmanuel on 06/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import XCTest
@testable import PinterestValley

class PinterestValleyTests: XCTestCase {
    
    var pinterest: Pinterest?
    var httpStore: HTTPStore?
    var constants: Constants?
    
    override func setUp() {
        super.setUp()
        
        // setup Pinterest Model
        pinterest = Pinterest()
        
        pinterest?.id = "xyZ123"
        pinterest?.likes = 2017
        pinterest?.liked_by_user = true
        
        
        // setup HTTPStore
        httpStore = HTTPStore()
        
        
        //setup Constants
        constants = Constants()
        constants?.apiURL = "https://pastebin.com/raw/wgkJgazE"
        constants?.jsonApiUrl = "https://pastebin.com/raw/json"
        constants?.pdfURL = "https://pastebin.com/raw/pdf"
        constants?.xmlURL = "https://pastebin.com/raw/xml"
        constants?.anyotherEndpoint = "https://pastebin.com/raw/hahaha"
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // test pinterest Id : String
    func testPinterestID() {
        
        XCTAssertEqual(pinterest?.id, "xyZ123")
    }
    
    // test Pinterest Likes : Int
    func testPinterestLikes() {
        XCTAssertEqual(pinterest?.likes, 2017)
    }
    
    //test Pinterest liked_by_user : Bool
    func testPinterestLikedByUser() {
        XCTAssertEqual(pinterest?.liked_by_user, true)
    }
    
    //
    // TEST Constants
    //
    // test Constants apiURL
    func testContantsApiURL() {
        XCTAssertEqual(constants?.apiURL, "https://pastebin.com/raw/wgkJgazE")
    }
    
    //test Constants JSON API URL
    func testConstantsJSONApiURL() {
        XCTAssertEqual(constants?.jsonApiUrl, "https://pastebin.com/raw/json")
    }
    
    // test Constants pdf URL
    func testConstantsPdfURL() {
        XCTAssertEqual(constants?.pdfURL, "https://pastebin.com/raw/pdf")
    }
    
    // test Constants xml URL
    func testConstantsXmlURL() {
        XCTAssertEqual(constants?.xmlURL, "https://pastebin.com/raw/xml")
    }
    
    // test Constants anyother endpoint
    func testConstantsAnyOtherEnpoint() {
        XCTAssertEqual(constants?.anyotherEndpoint, "https://pastebin.com/raw/hahaha")
    }
   
    
    
}

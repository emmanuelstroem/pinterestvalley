//
//  PinterestPersistanceData.swift
//  Pinterest
//
//  Created by Emmanuel on 06/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation
import UIKit

class PinterestPersistanceData: NSObject {
    
    static let sharedInstance: PinterestPersistanceData = {
        let instance = PinterestPersistanceData()
        
        return instance
    }()
    
    var uniquePinterestList: [Pinterest] = [Pinterest]()
    
    func setUniquePinterestList(withPinterest dataToAppend: Pinterest) {
        uniquePinterestList = [Pinterest]()
        uniquePinterestList.append(dataToAppend)
    }
    
    func addPinterestToList(pinterestToAppend: Pinterest) {
            uniquePinterestList.append(pinterestToAppend)
    }
    
    func getUniquePinterestList() -> [Pinterest] {
        
        return uniquePinterestList
    }
    
    func getPinterestList() -> [Pinterest] {
        var requiredPinterestList = [Pinterest]()
        
        if uniquePinterestList.count > 0 {
            for singlePinteresList in uniquePinterestList {
                requiredPinterestList.append(singlePinteresList)
            }
        }
//        else {
//            print("uniquePinterestList is EMPTY")
//            
//            PinterestListManager().getPinterests(){
//                succes in
//                
//                print("making api call")
//            }
//        }
//        
        return requiredPinterestList
    }
    
    func getSinglePinterest(index: Int) -> Pinterest {
        let singlePinterest = self.getPinterestList()[index]
        return singlePinterest
    }
    
    
}

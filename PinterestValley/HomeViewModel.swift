//
//  HomeViewModel.swift
//  PinterestValley
//
//  Created by Emmanuel on 08/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import Foundation

class HomeViewModel: PinterestListManager {
    
    var isDataAvailable = false
    
    func isPinterestListPresent() -> Bool {
        return isDataAvailable
    }
    
    
}

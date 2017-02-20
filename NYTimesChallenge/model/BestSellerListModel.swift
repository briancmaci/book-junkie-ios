//
//  BestSellerListModel.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class BestSellerListModel : NSObject {
    
    var listName : String = ""
    var displayName : String = ""  //UNIQUE
    var listIsSelected : Bool = false

    init(name:String, display:String) {
       
        super.init()
        
        listName = name
        displayName = display
    }
}

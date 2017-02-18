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
    var displayName : String = ""
    var updatedFrequency : ListUpdated = .Unknown
    var isSelected : Bool = false

    init(name:String, display:String, frequency:String) {
       
        super.init()
        
        listName = name
        displayName = display
        updatedFrequency = frequencyFromString(freq: frequency)
    }
}

extension BestSellerListModel {
    
    //Helper Methods
    func frequencyFromString( freq:String ) -> ListUpdated {
        
        switch freq {
            case FrequencyString.Weekly:
                return .Weekly
            case FrequencyString.Monthly:
                return .Monthly
            
            default:
                return .Unknown
        }
    }
}

// Frequency Struct
enum ListUpdated {
    case Weekly
    case Monthly
    case Unknown
}

// JSON Frequency Strings
struct FrequencyString {
    static let Weekly = "WEEKLY"
    static let Monthly = "MONTHLY"
}

//
//  BookModel.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/20/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

enum SaveState: Int {
    case none = 0, nextUp, finished
}

class BookModel: NSObject {

    var uid : String = ""  //UNIQUE
    var bookTitle : String = ""
    var author : String = ""
    var summary : String = ""
    var buyURL : String = ""
    var userRating : Int = 0
    var saveState : SaveState = .none
    
    init(title:String, auth:String, desc:String, buy:String) {
        
        super.init()
        
        bookTitle = title
        author = auth
        summary = desc
        buyURL = buy
        
        uid = toUID()
    }
    
    func toUID() -> String {
        let nsTitle = bookTitle as NSString
        var arr:[String] = nsTitle.components(separatedBy: " ")
        let charactersToRemove = NSCharacterSet.alphanumerics.inverted
        
        for (index,_) in arr.enumerated() {
            arr[index] = arr[index].lowercased()
            arr[index] = arr[index].trimmingCharacters(in:charactersToRemove)
        }
        
        return arr.joined(separator:"-")
    }
}

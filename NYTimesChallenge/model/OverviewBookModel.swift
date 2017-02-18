//
//  OverviewBookModel.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class OverviewBookModel: NSObject {

    //book information
    var bookTitle : String = ""
    var author : String = ""
    var summary : String = ""
    var publisher : String = ""
    
    //image information
    var imageURL : String = ""
    var imageWidth : Int = 0
    var imageHeight : Int = 0
    
    //list information
    var listRank : Int = 0
    var thisList : BestSellerListModel!
    
    //buy link (Amazon for now)
    var buyURL : String = ""
    
    
    init(title:String, auth:String, sum:String, pub:String, iurl:String, width:Int, height:Int, rank:Int, list:BestSellerListModel, buy:String) {
        
        super.init()
        
        bookTitle = title
        author = auth
        summary = sum
        publisher = pub
        imageURL = iurl
        imageWidth = width
        imageHeight = height
        listRank = rank
        thisList = list
        buyURL = buy
        
        print("Title: \(bookTitle), Rank: \(listRank), Author: \(author)")
    }
}

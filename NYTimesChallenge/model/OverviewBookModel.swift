//
//  OverviewBookModel.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class OverviewBookModel: BookModel {

    //book information
//    var bookTitle : String = ""
//    var author : String = ""
//    var summary : String = ""
    
    //image information
    var imageURL : String = ""
    var imageWidth : Int = 0
    var imageHeight : Int = 0
    
    //list information
    var listRank : Int = 0
    var thisList : BestSellerListModel!
    var weeksOnList : Int = 0
    
    //buy link (Amazon for now)
//    var buyURL : String = ""
    
    
    init(title:String, auth:String, sum:String, iurl:String, width:Int, height:Int, rank:Int, list:BestSellerListModel, weeks:Int, buy:String) {
        
        super.init(title: title, auth: auth, desc: sum, buy: buy)
        
        bookTitle = title
        author = auth
        summary = sum
        imageURL = iurl
        imageWidth = width
        imageHeight = height
        listRank = rank
        thisList = list
        weeksOnList = weeks
        buyURL = buy
    }
}

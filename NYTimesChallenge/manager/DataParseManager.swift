//
//  DataParseManager.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class DataParseManager: NSObject {

    class func parseDataIntoLists(data:Any?) -> [BestSellerListModel] {
    
        var lists : [BestSellerListModel] = [BestSellerListModel]()
        let dataDictionary = data as! Dictionary<String, AnyObject>
        let results = dataDictionary["results"] as! [AnyObject]
        
        for result in results {
            lists.append(BestSellerListModel(name: result.object(forKey:"list_name") as! String,
                                             display: result.object(forKey:"display_name") as! String))
        }
        
        let alphabetizedLists = lists.sorted(by: { $0.displayName < $1.displayName })
        
        return alphabetizedLists
    }
    
    class func parseDataIntoOverviewBooks(data:Any?, maxWeeks:Int) -> [OverviewBookModel] {
        
        var overviewBooks : [OverviewBookModel] = [OverviewBookModel]()
        let dataDictionary = data as! Dictionary<String, AnyObject>
        let lists = dataDictionary["results"]?["lists"] as! [AnyObject]
        
        // We have a double for-loop to keep track of the current list and all books added to it.
        for list in lists {
            
            let currentList = BestSellerListModel(name: list.object(forKey:"list_name") as! String,
                                                  display: list.object(forKey:"display_name") as! String)
            
            
            let books = list["books"] as! [AnyObject]
            
            for book in books {
                
                let wks = book.object(forKey:"weeks_on_list") as! Int
                
                if wks <= maxWeeks {
                overviewBooks.append(OverviewBookModel(title: book.object(forKey:"title") as! String,
                                                       auth: book.object(forKey:"author") as! String,
                                                       sum: book.object(forKey:"description") as! String,
                                                       iurl: book.object(forKey:"book_image") as! String,
                                                       width: book.object(forKey:"book_image_width") as! Int,
                                                       height: book.object(forKey:"book_image_height") as! Int,
                                                       rank: book.object(forKey:"rank") as! Int,
                                                       list: currentList,
                                                       weeks: wks,
                                                       buy: book.object(forKey:"amazon_product_url") as! String)
                )
                }
            }
            
        }
        
        return overviewBooks
    }
    
}

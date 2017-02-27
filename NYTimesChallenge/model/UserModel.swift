//
//  UserModel.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

// Awards Rank Variables
enum FinishedRank: Int{
    case noob = 0, pageTurner, bookworm, bookJunkie
}

let awardsRankThreshold : [Int] = [0, 5, 10, 15]

class UserModel: NSObject {

    static let sharedInstance = UserModel()
    
    var lists : [BestSellerListModel] = [BestSellerListModel]()
    var overview : [OverviewBookModel] = [OverviewBookModel]()
    var books : [String : BookModel] = [String : BookModel]()
}

extension UserModel {
    
    class func getReadBooksTotal() -> Int {
        
        var total:Int = 0
        
        for (_ , book) in sharedInstance.books {
            if book.saveState == .finished {
                total += 1
            }
        }
        
        return total
    }
    
    class func getRatingsTotal() -> Int {
    
        var total:Int = 0
        
        for (_ , book) in sharedInstance.books {
            if book.userRating > 0 {
                total += 1
            }
        }
        
        return total
    }
    
    //Enum incorporation is planned for future enhancements or possible model storage
    class func getFinishedRank() -> String {
        switch sharedInstance.rankFromThreshold() {
        case .noob:
            return K.StringFormat.RankNoob
            
        case .pageTurner:
            return K.StringFormat.RankPageTurner
            
        case .bookworm:
            return K.StringFormat.RankBookworm
            
        case .bookJunkie:
            return K.StringFormat.RankBookJunkie
            
        }
    }
    
    private func rankFromThreshold() -> FinishedRank {
        
        var currentIndex = 0
        
        //edge case for 0
        if UserModel.getReadBooksTotal() == 0 {
            return FinishedRank(rawValue: currentIndex)!
        }
        
        while currentIndex < awardsRankThreshold.count && UserModel.getReadBooksTotal() > awardsRankThreshold[currentIndex] {
            currentIndex += 1
        }
        
        return FinishedRank(rawValue: currentIndex - 1)!
    }
}

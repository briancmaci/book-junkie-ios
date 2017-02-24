//
//  Config.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/16/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

//Constants
struct K {
    
    //API Keys
    struct APIKey {
        static let NYTimes = "NYTimesAPIKey"
    }
    
    //Back End URLs
    struct BackEndURL {
        static let Base = "https://api.nytimes.com/svc/books/v3/"
        static let ListNames = "lists/names.json"
        static let ListDetail = "lists.json"
        static let Overview = "lists/overview.json"
        static let MostReadArticles = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/Books/1.json"
    }
    
    //Back End Params
    struct Param {
        static let APIKey = "api-key"
        static let List = "list"
    }
    
    //Colors
    struct Color {
        static let mainGray = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        static let redDetail = UIColor(red: 127/255, green: 1/255, blue: 1/255, alpha: 1)
        
        //UITableViewCells
        static let grayBG0 = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
        static let grayBG1 = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        static let selectedGreen = UIColor(red:0, green: 109/255, blue:5/255, alpha: 1)
    }
    
    //Icons
    struct Icon {
        static let HeaderBarLogo = "HeaderBarLogo"
        static let Home = "IconHome"
        static let Back = "IconBack"
        static let IconOverlayClose = "IconOverlayClose"
        static let IconDeleteRow = "IconDeleteRow"
    }
    
    //Storyboard IDs
    struct Storyboard {
        
        struct Name {
            static let Main = "Main"
        }
        
        struct ID {
            static let MainNavigation = "mainNavVC"
            static let Home = "homeVC"
            static let Lists = "listsVC"
            static let AllLists = "allListsVC"
            static let Books = "booksVC"
            static let Awards = "awardsVC"
        }
    }
    
    //NIB Names
    struct NIBName {
        static let BottomNavigation = "BottomNavigation"
        static let BookDetailOverlay = "BookDetailOverlay"
        
        //UITableViewCells
        static let MyListsCell = "MyListsCell"
        static let MyListsFooterCell = "MyListsFooterCell"
    }
    
    //UITableViewCell reuseIdentifiers
    struct ReuseID {
        static let MyListsCellID = "myListsCellID"
        static let MyListsFooterCellID = "myListsFooterCellID"
    }
    
    //Strings
    struct StringFormat {
        static let CopyrightVersion = "©%d BookJunkie  v%@.%@"
        
        //Book Detail Strings
        static let DetailByline = "BY %@"
        static let DetailRank = "#%d"
        static let DetailWeek0 = "NEW THIS WEEK"    //Not a format. Placed here for organization.
        static let DetailWeek1 = "%d WEEK ON THE LIST"
        static let DetailWeekDefault = "%d WEEKS ON THE LIST"
        
        //Lists Strings
        static let AddMore0 = "ADD LISTS"
        static let AddMoreDefault = "EDIT MY LISTS"
    }
    
    //Constant numerical values
    struct NumberConstant {
        
        static let BottomNavHeight : CGFloat = 65
        static let HeaderAndStatusBarsHeight : CGFloat = 64
        
        //My Lists TableView
        static let MyListsRowHeight : CGFloat = 44
        static let MyListsFooterHeight : CGFloat = 64
        
    }
}

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
    
    struct Screen {
        static let Width = UIScreen.main.bounds.size.width
        static let Height = UIScreen.main.bounds.size.height
    }
    
    //Colors
    struct Color {
        static let mainGray = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        static let redDetail = UIColor(red: 127/255, green: 1/255, blue: 1/255, alpha: 1)
        
        //UITableViewCells
        static let grayBG0 = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
        static let grayBG1 = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        static let selectedGreen = UIColor(red:0, green: 109/255, blue:5/255, alpha: 1)
        static let selectedYellow = UIColor(red:219/255, green: 183/255, blue:14/255, alpha: 1)
        static let statusNoneGray = UIColor(red:153/255, green:153/255, blue:153/255, alpha: 1)
    }
    
    //Icons
    struct Icon {
        static let HeaderBarLogo = "HeaderBarLogo"
        static let Home = "IconHome"
        static let Back = "IconBack"
        static let IconOverlayClose = "IconOverlayClose"
        static let IconDeleteRow = "IconDeleteRow"
        static let IconAddNextUpOff = "IconAddNextUpOff"
        static let IconAddFinishedOff = "IconAddFinishedOff"
        static let IconRowStarOff = "IconRowStarOff"
        static let IconRowStarOn = "IconRowStarOn"
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
            static let ListDetails = "listDetailsVC"
            static let AllLists = "allListsVC"
            static let Books = "booksVC"
            static let Awards = "awardsVC"
        }
    }
    
    //NIB Names
    struct NIBName {
        static let BottomNavigation = "BottomNavigation"
        static let OverviewBookDetailOverlay = "OverviewBookDetailOverlay"
        static let ListBookDetailOverlay = "ListBookDetailOverlay"
        
        //UITableViewCells
        static let MyListsCell = "MyListsCell"
        static let MyListsFooterCell = "MyListsFooterCell"
        static let MyListDetailsCell = "MyListDetailsCell"
        static let MyBookCell = "MyBookCell"
        
        //Book List Buttons
        static let BooksSubnavOffView = "BooksSubnavOffView"
        static let BooksSubnavOnView = "BooksSubnavOnView"
        
        //Book Rate Overlay
        static let BookRateOverlay = "BookRateOverlay"
    }
    
    //UITableViewCell reuseIdentifiers
    struct ReuseID {
        static let MyListsCellID = "myListsCellID"
        static let MyListsFooterCellID = "myListsFooterCellID"
        static let MyListDetailsCellID = "myListDetailsCellID"
        static let MyBookCellID = "myBookCellID"
    }
    
    //VC Titles
    struct VCTitle {
        static let MyLists = "MY LISTS"
        static let AllLists = "ALL LISTS"
        static let MyBooks = "MY BOOKS"
        static let MyAwards = "MY AWARDS"
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
        
        //Books Strings
        static let BookTitleNextUp = "BOOKS NEXT UP"
        static let BookTitleFinished = "BOOKS FINISHED"
        
        //Awards Strings
        static let RankHeader = "RANK"
        static let FinishedFooter = "BESTSELLERS FINISHED"
        static let RatingsFooter = "BESTSELLERS RATED"
        static let RankNoob = "NOOB!"
        static let RankPageTurner = "PAGE TURNER!"
        static let RankBookworm = "BOOKWORM!"
        static let RankBookJunkie = "BOOKJUNKIE!!"
        
        //Rating Overlay Strings
        static let RateHeader = "BESTSELLER: ACCOMPLISHED"
        static let RateSubheader = "How would you rate"
        static let RateTitle = "%@?"
        
        //Twitter
        static let TwitterFinishedCopy = "I just read\n\"%@\"\nand I give it %d stars!\n@BookJunkieApp #finishedIt"
        static let TwitterRateImageBase = "TwitterRate%d"
        
        //Book Detail Overlay Strings
        static let StatusNone = "NONE"
        static let StatusNextUp = "NEXT UP"
        static let StatusFinished = "FINISHED"
    }
    
    //Constant numerical values
    struct NumberConstant {
        
        static let BottomNavHeight : CGFloat = 65
        static let HeaderAndStatusBarsHeight : CGFloat = 64
        static let MyBooksSubNavigationHeight : CGFloat = 51
        
        //My Lists TableView
        static let MyListsRowHeight : CGFloat = 44
        static let MyListsFooterHeight : CGFloat = 64
        
        //Swipeable Button Size
        static let SwipeableButtonWidth : CGFloat = 57.0
    }
}

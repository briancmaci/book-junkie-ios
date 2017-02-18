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
    
    //Icons
    struct Icon {
        static let HeaderBarLogo = "HeaderBarLogo"
        static let Home = "IconHome"
        static let Back = "IconBack"
        
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
            static let Books = "booksVC"
            static let Awards = "awardsVC"
        }
    }
    
    //NIB Names
    struct NIBName {
        static let BottomNavigation = "BottomNavigation"
    }
    
    //Strings
    struct StringFormat {
        static let CopyrightVersion = "©%d BookJunkie  v%@.%@"
    }
}

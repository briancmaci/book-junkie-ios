//
//  AppUtilities.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/16/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class AppUtilities: NSObject {
    
    class func getKeysDictionary() -> [String: AnyObject] {
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            
            return dict
        }
        
        else {
            
            return [:]
        }
    }
    
    class func generateUUID() -> String {
        return UUID().uuidString
    }
    
    class func getViewControllerFromStoryboard( id:String ) -> BookJunkieBaseViewController {
        let storyboard = UIStoryboard(name: K.Storyboard.Name.Main, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! BookJunkieBaseViewController
    }
    

}

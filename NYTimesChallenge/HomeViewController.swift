//
//  HomeViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/16/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class HomeViewController: BookJunkieBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APICallManager.getBestSellerLists { (responseObject, error) in
            
            if responseObject != nil {
                UserModel.sharedInstance.lists = DataParseManager.parseDataIntoLists(data: responseObject)
                print("UserModel.lists: \(UserModel.sharedInstance.lists)")
            }
        }
        
        APICallManager.getBestSellerOverview { (responseObject, error) in
            
            if responseObject != nil {
                UserModel.sharedInstance.overview = DataParseManager.parseDataIntoOverviewBooks(data: responseObject)
                
                print("OverviewModel? \(UserModel.sharedInstance.overview)")
            }
        }
        
        APICallManager.getListDetailByName(which: "hardcover-fiction") { (responseObject, error) in
            if responseObject != nil {
                print("List Detail? \(responseObject)")
            }
        }
        
        APICallManager.getMostViewedArticles { (responseObject, error) in
            if responseObject != nil {
                //print("Most Read? \(responseObject)")
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


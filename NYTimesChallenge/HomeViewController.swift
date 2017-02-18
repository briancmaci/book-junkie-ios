//
//  HomeViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/16/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import Koloda
import SDWebImage

class HomeViewController: BookJunkieBaseViewController, KolodaViewDataSource, KolodaViewDelegate {
    
    @IBOutlet weak var copyrightLine:UILabel?
    @IBOutlet weak var kolodaView: KolodaView!
    
    //The level of "newness" for Overview books.
    let kMaxWeeks : Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load Overview
        loadOverviewBooks()
        
        //Init subviews
        initCopyrightLine()
        
        
        APICallManager.getBestSellerLists { (responseObject, error) in
            
            if responseObject != nil {
                UserModel.sharedInstance.lists = DataParseManager.parseDataIntoLists(data: responseObject)
                print("UserModel.lists: \(UserModel.sharedInstance.lists)")
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
    
    func loadOverviewBooks() {
        
        APICallManager.getBestSellerOverview { (responseObject, error) in
            
            if responseObject != nil {
                UserModel.sharedInstance.overview = DataParseManager.parseDataIntoOverviewBooks(data: responseObject, maxWeeks:self.kMaxWeeks)
                
                ////books loaded. load images.
                self.initKoloda()

                ////set interactivity on book.
                
            }
        }
        
    }
    
    func initKoloda() {
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    func initCopyrightLine() {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        
        let copyStr = String(format:K.StringFormat.CopyrightVersion, components.year!, Bundle.main.releaseVersionNumber!, Bundle.main.buildVersionNumber!)
        
        copyrightLine?.text = copyStr
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ////Koloda Methods
    public func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let arr = Array(UserModel.sharedInstance.overview)
       
        let thisModel:OverviewBookModel = arr[index] as OverviewBookModel
        let thisURL = thisModel.imageURL
        
        let imgView = OverviewBookView(model:thisModel)
        
        imgView.sd_setImage(with: URL(string:thisURL))
        
        return imgView
    }
    
    public func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return UserModel.sharedInstance.overview.count
    }


}


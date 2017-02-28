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
import SafariServices

class HomeViewController: BookJunkieBaseViewController, KolodaViewDataSource, KolodaViewDelegate, OverviewBookDelegate, BaseBookDetailOverlayDelegate, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var copyrightLine:UILabel!
    @IBOutlet weak var kolodaView: KolodaView!
    
    var bookDetailOverlay : OverviewBookDetailOverlay!
    
    //The level of "newness" for Overview books.
    let kMaxWeeks : Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load Overview
        loadOverviewBooks()
        
        //Load Books -- Completed here so we have them populated in UserModel for Books and Lists views
        loadSavedBooks()
        
        //Init subviews
        initCopyrightLine()
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
    
    func loadSavedBooks() {
        UserModel.sharedInstance.books = CoreDataManager.retrieveBooks()
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
    
    func initOverviewBookDetailOverlay(thisModel:OverviewBookModel) {
        
        bookDetailOverlay = OverviewBookDetailOverlay.instanceFromNib(name: K.NIBName.OverviewBookDetailOverlay) as? OverviewBookDetailOverlay
        
        bookDetailOverlay.delegate = self
        
        bookDetailOverlay?.populateOverview(model: thisModel)
        
        
        bookDetailOverlay?.frame = bookDetailOverlay.offFrame
        
        view.addSubview(bookDetailOverlay!)
        
        //animate In
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.bookDetailOverlay.frame = self.bookDetailOverlay.onFrame
        }, completion: nil)
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
        
        let thisModel:OverviewBookModel = UserModel.sharedInstance.overview[index] as OverviewBookModel
        let imgView = OverviewBookView(model:thisModel)
        
        imgView.sd_setImage(with: URL(string:thisModel.imageURL)) { (img, error, type, url) in
            
            if error == nil {
                imgView.alpha = 0
                
                UIView.animate(withDuration: 0.3, animations: {
                    imgView.alpha = 1
                })
            }
        }
        //imgView.sd_setImage(with: URL(string:thisModel.imageURL))
        
        imgView.delegate = self
        
        return imgView
    }
    
    public func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return UserModel.sharedInstance.overview.count
    }
    
    ////MARK - OverlayBookDelegate Methods
    internal func overviewTapped(model: OverviewBookModel) {
        initOverviewBookDetailOverlay(thisModel: model)
    }
    
    ////MARK - BaseBookDetailOverlayDelegate Methods
    internal func addToNextUpTapped(model:BookModel) {
        print("Add this book next: \(model.bookTitle)")
    }
    
    internal func buyBookTapped(url: String) {
        
        //Load Buy Link in SafariViewController
        let svc = SFSafariViewController(url: NSURL(string: url)! as URL, entersReaderIfAvailable: true)
        svc.view.tintColor = UIColor.black
        //svc.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.present(svc, animated: true, completion: nil)
        
        svc.delegate = self
        
        //Hide Bottom Nav
        getBottomNavigation().show(visible: false)
    }
    
    internal func overlayClosed() {
        //animate Out
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.bookDetailOverlay.frame = self.bookDetailOverlay.offFrame
        }) { (true) in
            //swipe Right
            self.kolodaView.swipe(.right)
            
            //Remove Detail and Blur
            self.bookDetailOverlay.removeFromSuperview()
            self.bookDetailOverlay = nil
        }
        
    }

}


//
//  BookJunkieBaseViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import SafariServices

class BookJunkieBaseViewController: UIViewController, BookRateOverlayDelegate, SFSafariViewControllerDelegate, RankUpOverlayDelegate {

    var rankOverlay:RankUpOverlay!
    var rateOverlay:BookRateOverlay!
    
    //This will be used with all table views for resizing purposes
    var tableMaxHeight:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Initialize navigationBar titleView
        
        customizeHeaderTitleView()
        customizeBackButton()
        customizeRightBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeHeaderTitleView() {
        
        let headerLogoImage = UIImage(named: K.Icon.HeaderBarLogo)
        navigationItem.titleView = UIImageView(image: headerLogoImage)
    }
    
    func customizeBackButton() {
        
        let backImage = UIImage(named: K.Icon.Back)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    func customizeRightBarButton() {
        
        //check if we are already on homepage
        if type(of: self) == type(of: HomeViewController()) {
            return
        }
        
        let homeButton = UIBarButtonItem(image: UIImage(named:K.Icon.Home), style: .plain, target: self, action: #selector(onHomeTapped(sender:)))
        
        navigationItem.rightBarButtonItem = homeButton
    }
    
    func onHomeTapped(sender:AnyObject) {
        
        //pop to first view in stack
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    // Rank Overlay Load
    func loadRankOverlay(rank:Int) {
        
        rankOverlay = BookRateOverlay.instanceFromNib(name: K.NIBName.RankUpOverlay) as! RankUpOverlay
        rankOverlay.frame = CGRect(x:0, y:0, width:K.Screen.Width, height:K.Screen.Height)
        rankOverlay.populateOverlay(rankLevel: rank)
        
        rankOverlay.delegate = self
        
        view.addSubview(rankOverlay)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        getBottomNavigation().show(visible: false)
    }
    
    // Rate Overlay Load
    func loadRateOverlay(model:BookModel) {
        
        rateOverlay = BookRateOverlay.instanceFromNib(name: K.NIBName.BookRateOverlay) as! BookRateOverlay
        rateOverlay.frame = CGRect(x:0, y:0, width:K.Screen.Width, height:K.Screen.Height)
        rateOverlay.populateOverlay(model: model)
        rateOverlay.initRateStars()
        
        rateOverlay.delegate = self
        
        view.addSubview(rateOverlay)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        getBottomNavigation().show(visible: false)
    }
    
    // Bottom Navigation access
    func getBottomNavigation() -> BottomNavigation {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.bottomNav!
        
    }
    
    //// MARK - RankUpOverlayDelegate Methods
    func rankOverlayCloseTapped() {
        removeRankOverlay()
    }
    
    func rankOverlayShareTapped(rank: Int) {
        FabricManager.tweetRankedUp(forRankLevel: rank, vc: self)
    }
    
    //// MARK - BookRateOverlayDelegate Methods
    func rateOverlayCloseTapped(model: BookModel) {
        removeRateOverlay()
        CoreDataManager.updateBookWith(rating: model.userRating, uid: model.uid)
    }
    
    func rateOverlayShareTapped(model: BookModel) {
        FabricManager.tweetFinished(forBook: model, vc: self)
        CoreDataManager.updateBookWith(rating: model.userRating, uid: model.uid)
    }
    
    func removeRankOverlay() {
        rankOverlay.removeFromSuperview()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        getBottomNavigation().show(visible: true)
    }
    
    func removeRateOverlay() {
        rateOverlay.removeFromSuperview()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        getBottomNavigation().show(visible: true)
        
        //check for rank up!
        checkRankUpStatus()
    }
    
    func checkRankUpStatus() {
        
        var rankValue:Int = 0
        for (index, threshold) in UserModel.sharedInstance.awardsRankThreshold.enumerated() {
            
            if threshold == UserModel.getReadBooksTotal() {
                
                rankValue = index
                break
            }
        }
        
        if rankValue > 0 {
            loadRankOverlay(rank: rankValue)
        }
    }
    
    func updateBookSaveStateWith(model:BookModel) {
        
        //Check if book exists in lists first
        if UserModel.sharedInstance.books[model.uid] == nil {
            UserModel.sharedInstance.books[model.uid] = model
            CoreDataManager.saveBook(thisBook: model)
        }
            
        else {
            CoreDataManager.updateBookWith(saveState: model.saveState, uid: model.uid)
        }
    }
    
    ////SFSafariViewControllerDelegate Methods
    internal func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        controller.dismiss(animated: true, completion: nil)
        
        //Show Bottom Nav
        getBottomNavigation().show(visible: true)
    }

    ////MARK - BaseBookDetailOverlayDelegate Methods
    internal func addToNextUpTapped(model:BookModel) {
        model.saveState = .nextUp
        updateBookSaveStateWith(model: model)
    }
    
    internal func finishedTapped(model:BookModel) {
        model.saveState = .finished
        updateBookSaveStateWith(model:model)
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
}

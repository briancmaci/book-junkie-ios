//
//  BookJunkieBaseViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class BookJunkieBaseViewController: UIViewController, BookRateOverlayDelegate {

    var rateOverlay:BookRateOverlay!
    
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
    
    // Book Rate Overlay Delegate
    func overlayCloseTapped(model: BookModel) {
        
        removeRateOverlay()
        CoreDataManager.updateBookWith(rating: model.userRating, uid: model.uid)
    }
    
    func overlayShareTapped(model: BookModel) {
        print("Share model with Twitter")
        
        //Twitter ON COMPLETE -- removeOverlay
        //removeRateOverlay()
        
        FabricManager.tweetFinished(forBook: model, vc: self)
        
        CoreDataManager.updateBookWith(rating: model.userRating, uid: model.uid)
    }
    
    func removeRateOverlay() {
        rateOverlay.removeFromSuperview()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        getBottomNavigation().show(visible: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

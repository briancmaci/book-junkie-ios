//
//  BottomNavigation.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class BottomNavigation: UIView {

    @IBOutlet weak var listsButton : UIButton!
    @IBOutlet weak var booksButton : UIButton!
    @IBOutlet weak var awardsButton : UIButton!
    
    //This is tracked to remove redundant viewcontroller pushes
    var currentVC:BookJunkieBaseViewController = HomeViewController()
    
    let onFrame:CGRect = CGRect(x:0,
                                y:K.Screen.Height - K.NumberConstant.BottomNavHeight,
                                width:K.Screen.Width,
                                height:K.NumberConstant.BottomNavHeight)
    
    let offFrame:CGRect = CGRect(x:0,
                                 y:K.Screen.Height,
                                 width:K.Screen.Width,
                                 height:K.NumberConstant.BottomNavHeight)
    
    @IBAction func onListsTapped(sender:UIButton){
        let newVC = AppUtilities.getViewControllerFromStoryboard(id: K.Storyboard.ID.Lists) as! ListsViewController
        pushNewViewController(vc: newVC)
    }
    
    @IBAction func onBooksTapped(sender:UIButton){
        let newVC = AppUtilities.getViewControllerFromStoryboard(id: K.Storyboard.ID.Books) as! BooksViewController
        pushNewViewController(vc: newVC)
        
    }
    
    @IBAction func onAwardsTapped(sender:UIButton){
        let newVC = AppUtilities.getViewControllerFromStoryboard(id: K.Storyboard.ID.Awards) as! AwardsViewController
        pushNewViewController(vc: newVC)
        
    }
    
    func pushNewViewController( vc : BookJunkieBaseViewController) {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        
        //// MARK - Not Necessary. Check to make sure we are not navigating to the same view controller
        //if type(of: currentVC) == type(of: vc) {
        //    return
        //}
        navController.pushViewController(vc, animated:true)
        currentVC = vc
    }
    
    func show(visible:Bool) {
        
        //Show bottom navigation
        if visible == true {
            UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
                self.frame = self.onFrame
            }, completion: nil)
        }
        
        //Hide bottom navigation
        else {
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options: [], animations: {
                self.frame = self.offFrame
            }, completion: nil)
        
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}

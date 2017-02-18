//
//  BottomNavigation.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class BottomNavigation: UIView {

    @IBOutlet weak var listsButton : UIButton?
    @IBOutlet weak var booksButton : UIButton?
    @IBOutlet weak var awardsButton : UIButton?
    
    @IBAction func onListsTapped(sender:UIButton){
        let newVC = getViewControllerFromStoryboard(id: K.Storyboard.ID.Lists) as! ListsViewController
        pushNewViewController(vc: newVC)
    }
    
    @IBAction func onBooksTapped(sender:UIButton){
        let newVC = getViewControllerFromStoryboard(id: K.Storyboard.ID.Books) as! BooksViewController
        pushNewViewController(vc: newVC)
        
    }
    
    @IBAction func onAwardsTapped(sender:UIButton){
        let newVC = getViewControllerFromStoryboard(id: K.Storyboard.ID.Awards) as! AwardsViewController
        pushNewViewController(vc: newVC)
        
    }
    
    func getViewControllerFromStoryboard( id:String ) -> BookJunkieBaseViewController {
        let storyboard = UIStoryboard(name: K.Storyboard.Name.Main, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! BookJunkieBaseViewController
    }
    
    func pushNewViewController( vc : BookJunkieBaseViewController) {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.pushViewController(vc, animated:true)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: K.NIBName.BottomNavigation, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}

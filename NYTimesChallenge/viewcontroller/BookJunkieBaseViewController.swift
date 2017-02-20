//
//  BookJunkieBaseViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class BookJunkieBaseViewController: UIViewController {

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
    
    // Bottom Navigation access
    func getBottomNavigation() -> BottomNavigation {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.bottomNav!
        
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

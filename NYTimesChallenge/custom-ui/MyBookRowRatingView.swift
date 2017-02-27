//
//  MyBookRowRatingView.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/26/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class MyBookRowRatingView: UIView {

    @IBOutlet var rowRateStar:[UIImageView]!
    
    
    func initRowStars() {
        
        for (index, star) in rowRateStar.enumerated() {
            star.tag = index
        }
    }
    
    func setRowRate(rate:Int) {
        
        if rate == 0 {
            self.isHidden = true
            return
        }
        
        else {
            self.isHidden = false
            
            for star in rowRateStar {
                
                if star.tag <= rate - 1 {
                    star.image = UIImage(named: K.Icon.IconRowStarOn)
                }
                
                else {
                    star.image = UIImage(named: K.Icon.IconRowStarOff)
                }
            }
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

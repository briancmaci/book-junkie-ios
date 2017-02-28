//
//  RateStarButton.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/25/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class RateStarButtons: UIView {
    
    @IBOutlet var rateStar:[UIButton]!
    
    //@IBOutlet weak var
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func initRateStars() {
        
        for (index, star) in rateStar.enumerated() {
            star.adjustsImageWhenHighlighted = false
            star.tag = index
        }
    }
    
    func updateStarRating(which:Int) {
        
        for star in rateStar {
            if star.tag <= which {
                star.isSelected = true
            }
            
            else {
                star.isSelected = false
            }
        }
    }
    

}

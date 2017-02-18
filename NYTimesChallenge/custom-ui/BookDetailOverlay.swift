//
//  BookDetailOverlay.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/18/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class BookDetailOverlay: UIView {

    //IBOutlets
    
    //Rank
    @IBOutlet weak var rankLabel : UILabel?
    @IBOutlet weak var listNameLabel : UILabel?
    @IBOutlet weak var weekLabel : UILabel?
    
    //Image
    @IBOutlet weak var bookImageView : UIImageView?
    
    //Book Info
    @IBOutlet weak var titleLabel : UILabel?
    @IBOutlet weak var authorLabel : UILabel?
    @IBOutlet weak var descriptionTextView : UITextView?
    
    //Buttons
    @IBOutlet weak var addNextUpButton : UIButton?
    @IBOutlet weak var buyButton : UIButton?
    @IBOutlet weak var closeButton : UIButton?
    
    //Views
    @IBOutlet weak var containerView : UIView?
    @IBOutlet weak var backgroundView : UIView?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

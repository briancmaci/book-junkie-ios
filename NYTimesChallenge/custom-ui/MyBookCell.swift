//
//  MyBookCell.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/19/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import SWTableViewCell

class MyBookCell: SWTableViewCell {
    
    @IBOutlet weak var listLabel : UILabel!
    @IBOutlet weak var background : UIView!
    @IBOutlet weak var iconNext : UIImageView!
    @IBOutlet weak var rowRatingView : MyBookRowRatingView!
    
    var thisModel : BookModel!
    var thisIndex : Int!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populate( model:BookModel, index:Int ) {
        
        thisModel = model
        thisIndex = index
        
        listLabel.text = thisModel.bookTitle.uppercased()
        
        //Set row accessory
        toggleRowAccessories()
        rowRatingView.initRowStars()
        rowRatingView.setRowRate(rate: thisModel.userRating)
    }
    
    func toggleRowAccessories() {
        
        switch thisModel.saveState {
        case .finished:
            iconNext.isHidden = true
            rowRatingView.isHidden = false
            
        case .nextUp, .none:
            iconNext.isHidden = false
            rowRatingView.isHidden = true
        }
    }
}

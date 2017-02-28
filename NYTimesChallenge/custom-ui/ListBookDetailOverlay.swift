//
//  OverviewBookDetailOverlay.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/18/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

//protocol OverviewDetailOverlayDelegate : BaseBookDetailOverlayDelegate {
//    func buyBookTapped( url:String )
//    func addToNextUpTapped( model:OverviewBookModel )
//}

class ListBookDetailOverlay : BaseBookDetailOverlay {

    //IBOutlets
    
    //Views
    @IBOutlet weak var bookContentView : UIView!
    
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var ratingView : UIView!
    @IBOutlet weak var ratingStars : MyBookRowRatingView!
    
    @IBOutlet weak var finishButton : UIButton!
    @IBOutlet weak var deleteButton : UIButton!
    
    //Constraints needing change per content size
    @IBOutlet weak var bookContentViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var descriptionHeightConstraint : NSLayoutConstraint!
    
    override func populate(model:BookModel) {
        
        super.populate(model: model)
        thisModel = model as BookModel
        
        //build layout based on SaveState
        updateOverlayForSaveState()
    }
    
    func updateOverlayForSaveState() {
        
        //start hidden. Only activate if this specific finished book has been rated
        ratingView.isHidden = true
        
        switch (thisModel?.saveState)! {
        
        case SaveState.none:
            statusLabel.text = K.StringFormat.StatusNone
            statusLabel.textColor = K.Color.statusNoneGray
            
            //button updates
            
        case SaveState.nextUp:
            statusLabel.text = K.StringFormat.StatusNextUp
            statusLabel.textColor = K.Color.selectedYellow
            
            //button updates
            
        case SaveState.finished:
            statusLabel.text = K.StringFormat.StatusFinished
            statusLabel.textColor = K.Color.selectedGreen
            
            if (thisModel?.userRating)! > 0 {
                ratingView.isHidden = false
                ratingStars.initRowStars()
                ratingStars.setRowRate(rate: (thisModel?.userRating)!)
            }
            
            //button updates
            
            
        }
        
        //resize description to fit. resize bookContentView to fit. 
        descriptionHeightConstraint.constant = descriptionTextView.getTextHeight()
        layoutIfNeeded()
        
        if ratingView.isHidden == true {
            bookContentViewHeightConstraint.constant = statusLabel.frame.origin.y + statusLabel.frame.size.height
        }
        
        else {
            bookContentViewHeightConstraint.constant = ratingView.frame.origin.y + ratingView.frame.size.height
        }
        
        layoutIfNeeded()
        
    }
}

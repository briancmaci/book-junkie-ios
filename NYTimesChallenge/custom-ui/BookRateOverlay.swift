//
//  BookRateOverlay.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/25/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

protocol BookRateOverlayDelegate {
    func overlayCloseTapped(model:BookModel)
    func overlayShareTapped(model:BookModel)
}

class BookRateOverlay: UIView {
    
    @IBOutlet weak var headerLabel:UILabel!
    @IBOutlet weak var subheaderLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var rateStarButtons:RateStarButtons!
    
    @IBOutlet weak var shareButton:UIButton!
    @IBOutlet weak var closeButton:UIButton!
    
    @IBOutlet weak var backgroundCover:UIView!
    @IBOutlet weak var overlayContainer:UIView!
    
    var delegate : BookRateOverlayDelegate?
    var userBookRating : Int = 0
    
    //Rate Star IBAction
    @IBAction func starTapped(sender: UIButton) {
        
        //We are going to set rate and enable buttons
        rateStarButtons.updateStarRating(which: sender.tag)
        userBookRating = sender.tag + 1
        thisModel.userRating = userBookRating
        
        enableShare(on: true)
    }
    
    @IBAction func closeTapped(sender: UIButton) {
        delegate?.overlayCloseTapped(model:thisModel)
    }
    
    @IBAction func shareTapped(sender: UIButton) {
        delegate?.overlayShareTapped(model:thisModel)
    }
    
    var thisModel:BookModel!
    
    func populateOverlay(model:BookModel) {
        
        thisModel = model
        
        headerLabel.text = K.StringFormat.RateHeader
        subheaderLabel.text = K.StringFormat.RateSubheader
        titleLabel.text = String(format:K.StringFormat.RateTitle, thisModel.bookTitle.capitalized)
        
        // Buttons start disabled until book is rated
        enableShare(on: false)
    }
    
    func enableShare(on:Bool) {
        shareButton.isUserInteractionEnabled = on
        shareButton.alpha = on == true ? 1 : 0.2
    }
    
    func initRateStars() {
        rateStarButtons.initRateStars()
    }
}

//
//  BaseBookDetailOverlay.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/27/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

@objc protocol BaseBookDetailOverlayDelegate {
    func overlayClosed()
    @objc optional func buyBookTapped( url:String )
    @objc optional func addToNextUpTapped( model:BookModel )
    @objc optional func finishedTapped( model:BookModel )
    @objc optional func deleteTapped( model:BookModel )
}

class BaseBookDetailOverlay: UIView {

    //Book Info
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    @IBOutlet weak var descriptionTextView : UITextView!
    
    //Buttons
    @IBOutlet weak var addNextUpButton : UIButton!
    @IBOutlet weak var buyButton : UIButton!
    @IBOutlet weak var closeButton : UIButton!
    
    var delegate : BaseBookDetailOverlayDelegate?
    var thisModel : BookModel?
    
    //Animation frames
    let offFrame : CGRect = CGRect(x:K.Screen.Width,
                                   y:0,
                                   width:K.Screen.Width,
                                   height:K.Screen.Height - K.NumberConstant.BottomNavHeight - K.NumberConstant.HeaderAndStatusBarsHeight)
    
    let onFrame : CGRect = CGRect(x:0,
                                  y:0,
                                  width:K.Screen.Width,
                                  height:K.Screen.Height - K.NumberConstant.BottomNavHeight - K.NumberConstant.HeaderAndStatusBarsHeight)

    
    func populate(model:BookModel) {
        thisModel = model

        titleLabel.text = thisModel?.bookTitle
        authorLabel.text = thisModel?.author.uppercased()
        descriptionTextView.text = thisModel?.summary
        
        //Set Buy Button enable based on buyLink
        buyButton.isEnabled = thisModel?.buyURL == "" ? false : true
    }
    
    ////MARK - Delegate Methods
    @IBAction func closeButtonTapped( sender: UIButton ) {
        delegate?.overlayClosed()
    }
    
    @IBAction func buyButtonTapped( sender: UIButton ) {
        delegate?.buyBookTapped!(url: (thisModel?.buyURL)! )
    }
    
    @IBAction func addNextButtonTapped( sender: UIButton ) {
        delegate?.addToNextUpTapped!(model:thisModel! )
    }
    
    @IBAction func finishedButtonTapped( sender: UIButton ) {
        delegate?.finishedTapped!(model:thisModel!)
    }
    
    @IBAction func deleteButtonTapped( sender: UIButton ) {
        delegate?.deleteTapped!(model: thisModel!)
    }
    
    
}

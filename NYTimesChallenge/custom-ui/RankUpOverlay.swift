//
//  RankUpOverlay.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/25/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

protocol RankUpOverlayDelegate {
    func rankOverlayCloseTapped()
    func rankOverlayShareTapped(rank:Int)
}

class RankUpOverlay: UIView {
    
    @IBOutlet weak var headerLabel:UILabel!
    @IBOutlet weak var subheaderLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    
    @IBOutlet weak var shareButton:UIButton!
    @IBOutlet weak var closeButton:UIButton!
    
    @IBOutlet weak var backgroundCover:UIView!
    @IBOutlet weak var overlayContainer:UIView!
    
    var delegate : RankUpOverlayDelegate?
    var newRank : Int = 0
    
    @IBAction func closeTapped(sender: UIButton) {
        delegate?.rankOverlayCloseTapped()
    }
    
    @IBAction func shareTapped(sender: UIButton) {
        delegate?.rankOverlayShareTapped(rank:newRank)
    }
    
    func populateOverlay(rankLevel:Int) {
        
        newRank = rankLevel
        
        headerLabel.text = K.StringFormat.RankOverlayHeader
        subheaderLabel.text = K.StringFormat.RankSubheader
        titleLabel.text = K.StringFormat.RankTitle[rankLevel]
    }
}

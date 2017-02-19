//
//  BookDetailOverlay.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/18/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

protocol OverviewDetailOverlayDelegate {
    func overlayClosed()
}

class BookDetailOverlay: UIView {

    //IBOutlets
    
    //Rank
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var listNameLabel : UILabel!
    @IBOutlet weak var weekLabel : UILabel!
    
    //Image
    @IBOutlet weak var bookImageView : UIImageView!
    
    //Book Info
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var authorLabel : UILabel!
    @IBOutlet weak var descriptionTextView : UITextView!
    
    //Buttons
    @IBOutlet weak var addNextUpButton : UIButton!
    @IBOutlet weak var buyButton : UIButton!
    @IBOutlet weak var closeButton : UIButton!
    
    //Views
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var backgroundView : UIView!
    
    var delegate : OverviewDetailOverlayDelegate?
    
    var thisModel : OverviewBookModel?
    
    let beginFrame : CGRect = CGRect(x:UIScreen.main.bounds.size.width,
                                     y:0,
                                     width:UIScreen.main.bounds.size.width,
                                     height:UIScreen.main.bounds.size.height - K.NumberConstant.BottomNavHeight - K.NumberConstant.HeaderAndStatusBarsHeight)
    
    let endFrame : CGRect = CGRect(x:0,
                                   y:0,
                                   width:UIScreen.main.bounds.size.width,
                                   height:UIScreen.main.bounds.size.height - K.NumberConstant.BottomNavHeight - K.NumberConstant.HeaderAndStatusBarsHeight)
    
    func populate(model:OverviewBookModel) {
        thisModel = model
        
        //Fill all text
        rankLabel.text = String(format: K.StringFormat.DetailRank, (thisModel?.listRank)!)
        listNameLabel.text = thisModel?.thisList.displayName.uppercased()
        
        switch (thisModel?.weeksOnList)! as Int {
        case 0:
            weekLabel.text = K.StringFormat.DetailWeek0
        case 1:
            weekLabel.text = String(format: K.StringFormat.DetailWeek1, (thisModel?.weeksOnList)!)
        default:
            weekLabel.text = String(format: K.StringFormat.DetailWeekDefault, (thisModel?.weeksOnList)!)
        }
        
        titleLabel.text = thisModel?.bookTitle
        authorLabel.text = String(format: K.StringFormat.DetailByline, (thisModel?.author.uppercased())!)
        descriptionTextView.text = thisModel?.summary
        
        //Load book detail
        bookImageView.sd_setImage(with: URL(string:(thisModel?.imageURL)!))
    }
    
    @IBAction func closeButtonTapped( sender: UIButton ) {
        
        delegate?.overlayClosed()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

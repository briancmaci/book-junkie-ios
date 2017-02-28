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

class OverviewBookDetailOverlay: BaseBookDetailOverlay {

    //IBOutlets
    
    //Rank
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var listNameLabel : UILabel!
    @IBOutlet weak var weekLabel : UILabel!
    
    //Image
    @IBOutlet weak var bookImageView : UIImageView!
    
    //Views
//    @IBOutlet weak var containerView : UIView!
//    @IBOutlet weak var backgroundView : UIView!
    
    var thisOverviewModel : OverviewBookModel?
    
//    override var delegate: BaseBookDetailOverlayDelegate? {
//        didSet {
//            assert(delegate == nil || delegate is OverviewDetailOverlayDelegate, "The delegate of OverviewBookDetailOverlay must be of type `OverviewDetailOverlayDelegate`")
//        }
//    }
    
//    var thisModel : OverviewBookModel?
    
    func populateOverview(model:OverviewBookModel) {
        
        super.populate(model: model as BookModel)
        
        thisOverviewModel = model
        
        //Fill all text
        rankLabel.text = String(format: K.StringFormat.DetailRank, (thisOverviewModel?.listRank)!)
        listNameLabel.text = thisOverviewModel?.thisList.displayName.uppercased()
        
        switch (thisOverviewModel?.weeksOnList)! as Int {
        case 0:
            weekLabel.text = K.StringFormat.DetailWeek0
        case 1:
            weekLabel.text = String(format: K.StringFormat.DetailWeek1, (thisOverviewModel?.weeksOnList)!)
        default:
            weekLabel.text = String(format: K.StringFormat.DetailWeekDefault, (thisOverviewModel?.weeksOnList)!)
        }
        
        //titleLabel.text = thisModel?.bookTitle
        
        //Different author treatment for Overview Overlay
        authorLabel.text = String(format: K.StringFormat.DetailByline, (thisOverviewModel?.author.uppercased())!)
        //descriptionTextView.text = thisModel?.summary
        
        //Load book detail
        bookImageView.sd_setImage(with: URL(string:(thisOverviewModel?.imageURL)!))
        
        //Set Buy Button enable based on buyLink
        //buyButton.isEnabled = thisModel?.buyURL == "" ? false : true
    }
    
    ////MARK - Delegate Methods
//    @IBAction func buyButtonTapped( sender: UIButton ) {
//        delegate?.buyBookTapped(url: (thisModel?.buyURL)! )
//    }
//    
//    @IBAction func addNextButtonTapped( sender: UIButton ) {
//        delegate?.addToNextUpTapped(model:thisModel!)
//    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

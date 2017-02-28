//
//  OverviewBookDetailOverlay.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/18/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class OverviewBookDetailOverlay: BaseBookDetailOverlay {

    //IBOutlets
    
    //Rank
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var listNameLabel : UILabel!
    @IBOutlet weak var weekLabel : UILabel!
    
    //Image
    @IBOutlet weak var bookImageView : UIImageView!
    
    
    var thisOverviewModel : OverviewBookModel?
    
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
        
        //Different author treatment for Overview Overlay
        authorLabel.text = String(format: K.StringFormat.DetailByline, (thisOverviewModel?.author.uppercased())!)
        
        
        //Load book detail
        bookImageView.sd_setImage(with: URL(string:(thisOverviewModel?.imageURL)!))
    }
}

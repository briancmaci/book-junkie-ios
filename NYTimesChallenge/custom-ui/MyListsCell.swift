//
//  MyListsCell.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/19/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import SWTableViewCell

class MyListsCell: SWTableViewCell {
    
    @IBOutlet weak var listLabel : UILabel!
    @IBOutlet weak var background : UIView!
    @IBOutlet weak var iconNext : UIImageView!
    @IBOutlet weak var iconAdded : UIImageView!
    
    var thisModel : BestSellerListModel!
    var thisIndex : Int!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate( model:BestSellerListModel, index:Int ) {
        
        thisModel = model
        thisIndex = index
        
        listLabel.text = thisModel.displayName.uppercased()
        
    }
    
    func setFor(myLists:Bool) {
        iconAdded.isHidden = true           //always hide this to start. 
        iconNext.isHidden = !myLists
    }
    
    func updateRowWith(model:BestSellerListModel) {
        thisModel = model
        setThisListState()
        updateTextColorForState()
    }
    
    func setThisListState() {
        iconAdded.isHidden = !thisModel.listIsSelected
    }
    
    func updateTextColorForState() {
    
        if thisModel.listIsSelected == true {
            listLabel.textColor = K.Color.selectedGreen
        }
        
        else {
            listLabel.textColor = K.Color.mainGray
        }
    }
}

//
//  MyListDetailsCell.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/24/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import SWTableViewCell

class MyListDetailsCell: SWTableViewCell {

    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var background : UIView!
    @IBOutlet weak var saveIndicator : UIView!
    
    var thisModel:BookModel!
    var thisIndex:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populate( model:BookModel, index:Int ) {
        
        thisModel = model
        thisIndex = index
        
        titleLabel.text = thisModel.bookTitle.uppercased()
        rankLabel.text = String(format:"%d", thisIndex + 1)
        
    }
    
//    func updateRowWith(model:BookModel) {
//        thisModel = model
//        updateSaveState()
//    }
    
    func updateSaveState() {
        
        switch thisModel.saveState {
        case .none:
            saveIndicator.backgroundColor = UIColor.clear
        
        case .nextUp:
            saveIndicator.backgroundColor = K.Color.selectedYellow
            
        case .finished:
            saveIndicator.backgroundColor = K.Color.selectedGreen
        }
        
    }
}

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
        
        if thisIndex % 2 == 0 {
            background.backgroundColor = K.Color.grayBG0
        }
        
        else {
            background.backgroundColor = K.Color.grayBG1
        }
    }
}

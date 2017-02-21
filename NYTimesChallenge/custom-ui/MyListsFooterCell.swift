//
//  MyListsFooterCell.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/19/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class MyListsFooterCell: UITableViewCell {
    
    @IBOutlet weak var addLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateAddMore(num:Int) {
        
        if num > 0 {
            addLabel.text = K.StringFormat.AddMoreDefault
        }
        
        else {
            addLabel.text = K.StringFormat.AddMore0
        }
    }
}

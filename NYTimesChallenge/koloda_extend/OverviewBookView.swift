//
//  OverviewBookView.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/18/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class OverviewBookView: UIImageView {
    
    var thisModel:OverviewBookModel?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init( model:OverviewBookModel) {
        
        super.init(frame: CGRect(x:0, y:0, width:0, height:0))
        
        thisModel = model
        
        isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gestureRecognizer:)))
        addGestureRecognizer(tapRecognizer)
    }
    
    func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        //let tappedImageView = gestureRecognizer.view!
        
        print("IMAGE TAPPED! \(thisModel?.bookTitle)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

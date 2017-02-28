//
//  UITableViewExtension.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/20/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

extension UITableView {
    
    func sizeToContent(maxHeight:CGFloat, bottom:NSLayoutConstraint) {
        
        
        var frameHeight:CGFloat = 0
        
        
    
        for i in 0...numberOfSections {
            
            let indexPath:IndexPath = NSIndexPath(row: 0, section: i) as IndexPath
            let height:CGFloat = rectForRow(at: indexPath).size.height
            
            frameHeight = frameHeight + (height * CGFloat(numberOfRows(inSection: i)))
        }
        
        if frameHeight >= maxHeight {
            bottom.constant = K.NumberConstant.BottomNavHeight
            layoutIfNeeded()
        }
        
        else {
            bottom.constant = maxHeight - frameHeight
            layoutIfNeeded()
        }
        
    }
}

//
//  UITableViewExtension.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/20/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

extension UITableView {
    
    func sizeToContent(bottom:NSLayoutConstraint) {
        
        if contentSize.height >= frame.size.height {
            return
        }
        
        //The minimum constraint value
        let constraintMinimum = K.NumberConstant.BottomNavHeight
        let maxHeight = UIScreen.main.bounds.height - constraintMinimum
        
        if contentSize.height < maxHeight {
             let newConstraintValue = maxHeight - contentSize.height
            
            bottom.constant = newConstraintValue
            layoutIfNeeded()
        }
        
        
        
    }
}

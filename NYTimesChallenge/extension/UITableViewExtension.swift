//
//  UITableViewExtension.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/20/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

extension UITableView {
    
    func sizeToContent(maxHeight:CGFloat, bottom:NSLayoutConstraint) {
        
        
//        if contentSize.height >= frame.size.height {
//            bottom.constant = K.NumberConstant.BottomNavHeight - top.constant
//            layoutIfNeeded()
//            return
//        }
        
        //The minimum constraint value
//        let constraintMinimum = K.NumberConstant.BottomNavHeight
//        let maxHeight = K.Screen.Height - constraintMinimum - top.constant
//        
//        if contentSize.height < maxHeight {
//             let newConstraintValue = maxHeight - contentSize.height
//            
//            bottom.constant = newConstraintValue
//            layoutIfNeeded()
//        }
        
        if contentSize.height >= frame.size.height {
            bottom.constant = K.NumberConstant.BottomNavHeight
            layoutIfNeeded()
        }
        
        else {
            bottom.constant = maxHeight - contentSize.height
            layoutIfNeeded()
        }
        
    }
}

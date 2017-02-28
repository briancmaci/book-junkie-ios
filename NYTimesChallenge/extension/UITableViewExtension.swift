//
//  UITableViewExtension.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/20/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

extension UITableView {
    
    func sizeToContent(maxHeight:CGFloat, bottom:NSLayoutConstraint) {
                
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

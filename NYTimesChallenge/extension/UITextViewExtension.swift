//
//  UITextViewExtension.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/27/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

extension UITextView {
    
    func getTextHeight() -> CGFloat {
        
        let fixedWidth = frame.size.width
        sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        //kill scrolling
        isScrollEnabled = false
        
        return newSize.height
    }
}

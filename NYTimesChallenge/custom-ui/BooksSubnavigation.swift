//
//  BooksSubnavigation.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/24/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

protocol BooksSubnavigationDelegate {
    func nextUpTapped()
    func finishedTapped()
}

class BooksSubnavigation: UIView {

    var nextUpOff:BooksSubnavOffView!
    var nextUpOn:BooksSubnavOnView!
    var finishedOff:BooksSubnavOffView!
    var finishedOn:BooksSubnavOnView!
    
    var delegate:BooksSubnavigationDelegate?
    
    func initSubnav(){
        buildNextUpViews()
        buildFinishedViews()
        
        enableButtons()
    }
    
    func buildNextUpViews() {
        nextUpOff = BooksSubnavOffView.instanceFromNib(name: K.NIBName.BooksSubnavOffView) as? BooksSubnavOffView
        
        nextUpOn = BooksSubnavOffView.instanceFromNib(name: K.NIBName.BooksSubnavOnView) as? BooksSubnavOnView
        
        let nextUpFrame = CGRect(x:0, y:0, width:K.Screen.Width/2, height:K.NumberConstant.HeaderAndStatusBarsHeight)
        
        nextUpOff.frame = nextUpFrame
        nextUpOn.frame = nextUpFrame
        
        nextUpOff.titleLabel.text = K.StringFormat.BookTitleNextUp
        nextUpOn.titleLabel.text = K.StringFormat.BookTitleNextUp
        
        addSubview(nextUpOn)
        addSubview(nextUpOff)
        
    }
    
    func buildFinishedViews() {
        
        finishedOff = BooksSubnavOffView.instanceFromNib(name: K.NIBName.BooksSubnavOffView) as? BooksSubnavOffView
        
        finishedOn = BooksSubnavOffView.instanceFromNib(name: K.NIBName.BooksSubnavOnView) as? BooksSubnavOnView
        
        let finishedFrame = CGRect(x:K.Screen.Width/2, y:0, width:K.Screen.Width/2, height:K.NumberConstant.HeaderAndStatusBarsHeight)
        
        finishedOff.frame = finishedFrame
        finishedOn.frame = finishedFrame
        
        finishedOff.titleLabel.text = K.StringFormat.BookTitleFinished
        finishedOn.titleLabel.text = K.StringFormat.BookTitleFinished
        
        addSubview(finishedOn)
        addSubview(finishedOff)
        
    }
    
    func enableButtons() {
        
        nextUpOff.hitButton.addTarget(self, action: #selector(nextUpTapped(sender:)), for: .touchUpInside)
        
        finishedOff.hitButton.addTarget(self, action: #selector(finishedTapped(sender:)), for: .touchUpInside)
    }
    
    func nextUpTapped(sender: UIButton!) {
        delegate?.nextUpTapped()
    }
    
    func finishedTapped(sender: UIButton!) {
        delegate?.finishedTapped()
    }
    
    func setCurrentList(toNextUp:Bool) {
        
        nextUpOff.isHidden = toNextUp
        nextUpOn.isHidden = !toNextUp
        
        finishedOff.isHidden = !toNextUp
        finishedOn.isHidden = toNextUp
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

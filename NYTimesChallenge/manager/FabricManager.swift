//
//  FabricManager.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/26/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit

class FabricManager: NSObject {

    class func initFabric() {
        Fabric.with([Twitter.self])
    }
    
    class func tweetFinished(forBook:BookModel, vc:BookJunkieBaseViewController) {
        
        let composer = TWTRComposer()
        
        composer.setText(String(format: K.StringFormat.TwitterFinishedCopy, forBook.bookTitle.capitalized, forBook.userRating))
        composer.setImage(UIImage(named: String(format:K.StringFormat.TwitterRateImageBase, forBook.userRating)))
        
        // Called from a UIViewController
        composer.show(from: vc) { result in
            if (result == TWTRComposerResult.cancelled) {
                //Tweet Canceled -- Return to RateOverlay
            }
            else {
                //Tweet Sending -- Close RateOverlay
                vc.removeRateOverlay()
            }
        }
    }
}

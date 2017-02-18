//
//  UserModel.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    static let sharedInstance = UserModel()
    
    var lists : Set<BestSellerListModel> = Set<BestSellerListModel>()
    var overview : Set<OverviewBookModel> = Set<OverviewBookModel>()
}

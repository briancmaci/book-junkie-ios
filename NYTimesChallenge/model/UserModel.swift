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
    
    var lists : [BestSellerListModel] = [BestSellerListModel]()
    var overview : [OverviewBookModel] = [OverviewBookModel]()
    var books : [String : BookModel] = [String : BookModel]()
}

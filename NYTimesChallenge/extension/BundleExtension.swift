//
//  BundleExtension.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/18/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

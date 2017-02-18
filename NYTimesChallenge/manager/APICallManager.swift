//
//  APICallManager.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/16/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import AFNetworking

class APICallManager: NSObject {
    
    static let manager : AFHTTPSessionManager = AFHTTPSessionManager()
    
    // getBestSellersLists
    class func getBestSellerLists(completionHandler: @escaping (Any?, Error?) -> ()) -> () {
        
        let apiKey = AppUtilities.getKeysDictionary()[K.APIKey.NYTimes]
        let params = [K.Param.APIKey:apiKey]
        
        manager.get(K.BackEndURL.Base + K.BackEndURL.ListNames,
                    parameters: params,
                    progress: nil,
                    success: {
                        (task: URLSessionDataTask?, responseObject: Any?) in
                        completionHandler(responseObject, nil)
                    },
                    failure: {
                        (task: URLSessionDataTask?, error: Error) in
                        completionHandler(nil, error)
                    }
        )

        
    }
    
    // getListDetail
    class func getListDetailByName(which:String, completionHandler: @escaping (Any?, Error?) -> ()) -> () {
        
        let apiKey = AppUtilities.getKeysDictionary()[K.APIKey.NYTimes]
        var params = [K.Param.APIKey:apiKey]
        
        //add detail
        params[K.Param.List] = which as AnyObject?
        
        manager.get(K.BackEndURL.Base + K.BackEndURL.ListDetail,
                    parameters: params,
                    progress: nil,
                    success: {
                        (task: URLSessionDataTask?, responseObject: Any?) in
                        completionHandler(responseObject, nil)
        },
                    failure: {
                        (task: URLSessionDataTask?, error: Error) in
                        completionHandler(nil, error)
        }
        )
        
        
    }
    
    // getListsOverview
    class func getBestSellerOverview(completionHandler: @escaping (Any?, Error?) -> ()) -> () {
        
        let apiKey = AppUtilities.getKeysDictionary()[K.APIKey.NYTimes]
        let params = [K.Param.APIKey:apiKey]
        
        manager.get(K.BackEndURL.Base + K.BackEndURL.Overview,
                    parameters: params,
                    progress: nil,
                    success: {
                        (task: URLSessionDataTask?, responseObject: Any?) in
                        completionHandler(responseObject, nil)
                    },
                    failure: {
                        (task: URLSessionDataTask?, error: Error) in
                        completionHandler(nil, error)
                    }
        )
        
        
    }
    
    // getMostViewedArticles
    class func getMostViewedArticles(completionHandler: @escaping (Any?, Error?) -> ()) -> () {
        
        let apiKey = AppUtilities.getKeysDictionary()[K.APIKey.NYTimes]
        let params = [K.Param.APIKey:apiKey]
        
        manager.get(K.BackEndURL.MostReadArticles,
                    parameters: params,
                    progress: nil,
                    success: {
                        (task: URLSessionDataTask?, responseObject: Any?) in
                        completionHandler(responseObject, nil)
        },
                    failure: {
                        (task: URLSessionDataTask?, error: Error) in
                        completionHandler(nil, error)
        }
        )
        
        
    }
    
}


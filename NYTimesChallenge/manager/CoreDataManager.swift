//
//  CoreDataManager.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/19/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    struct K {
        struct CoreData {
            static let appDelegate = UIApplication.shared.delegate as! AppDelegate
            static let managedContext = K.CoreData.appDelegate.managedObjectContext
            
            struct Entity {
                static let BestSellersList = "BestSellersList"
                static let OverviewBook = "OverviewBook"        //May not need
                static let MyBook = "MyBook"
            }
        }
    }
    
    
    
    class func saveBestSellersList(thisList: BestSellerListModel) {
        
        let entity =  NSEntityDescription.entity(forEntityName: K.CoreData.Entity.BestSellersList,
                                                 in:K.CoreData.managedContext)
        
        let list = NSManagedObject(entity: entity!,
                                     insertInto: K.CoreData.managedContext)
        
        list.setValue(thisList.displayName, forKey: "displayName")
        list.setValue(thisList.listName, forKey: "listName")
        list.setValue(thisList.listIsSelected, forKey: "listIsSelected")
        
        do {
            try K.CoreData.managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    class func retrieveBestSellersList() -> [BestSellerListModel] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity.BestSellersList)
        var listsInModels:[BestSellerListModel] = [BestSellerListModel]()
        
        do {
            let results =
                try K.CoreData.managedContext.fetch(fetchRequest)
            
            let coreDataLists = results as! [NSManagedObject]
            //var listsInModels:[BestSellerListModel] = [BestSellerListModel]()
            
            for result in coreDataLists {
                let thisModel = BestSellerListModel(name: result.value(forKey: "listName") as! String, display: result.value(forKey: "displayName") as! String)
                thisModel.listIsSelected = result.value(forKey: "listIsSelected") as! Bool
                listsInModels.append(thisModel)
                
                //return listsInModels
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            //return [BestSellerListModel]()
        }
        
        return listsInModels
    }
}

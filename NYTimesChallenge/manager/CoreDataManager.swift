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
                static let BestSellerList = "BestSellerList"
                static let BestSellerBook = "BestSellerBook"
            }
        }
    }
    
    
    
    class func saveBestSellerList(thisList: BestSellerListModel) {
        
        let entity =  NSEntityDescription.entity(forEntityName: K.CoreData.Entity.BestSellerList,
                                                 in:K.CoreData.managedContext)
        
        let list = NSManagedObject(entity: entity!,
                                     insertInto: K.CoreData.managedContext)
        
        list.setValue(thisList.displayName, forKey: "displayName")
        list.setValue(thisList.listNameEncoded, forKey: "listNameEncoded")
        list.setValue(thisList.listIsSelected, forKey: "listIsSelected")
        
        do {
            try K.CoreData.managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    class func updateBestSellerListSelection(listNameEncoded: String, isSelected: Bool) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity.BestSellerList)
        fetchRequest.predicate = NSPredicate(format: "listNameEncoded = %@", listNameEncoded)
        
        do {
            let fetchResults = try K.CoreData.managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
                if fetchResults?.count != 0{
                
                    let managedObject = fetchResults?[0]
                    managedObject?.setValue(isSelected, forKey: "listIsSelected")
                
                    do {
                        try K.CoreData.managedContext.save()
                        
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            //return [BestSellerListModel]()
        }
    }
    
    class func retrieveBestSellerLists() -> [BestSellerListModel] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity.BestSellerList)
        var listsInModels:[BestSellerListModel] = [BestSellerListModel]()
        
        do {
            let results =
                try K.CoreData.managedContext.fetch(fetchRequest)
            
            let coreDataLists = results as! [NSManagedObject]
            //var listsInModels:[BestSellerListModel] = [BestSellerListModel]()
            
            for result in coreDataLists {
                let thisModel = BestSellerListModel(name: result.value(forKey: "listNameEncoded") as! String, display: result.value(forKey: "displayName") as! String)
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
    
    class func retrieveBooks() -> [String : BookModel] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity.BestSellerBook)
        var booksInModels:[String : BookModel] = [String : BookModel]()
        
        do {
            let results =
                try K.CoreData.managedContext.fetch(fetchRequest)
            
            let coreDataLists = results as! [NSManagedObject]
            //var listsInModels:[BestSellerListModel] = [BestSellerListModel]()
            
            for result in coreDataLists {
                let thisModel = BookModel(title: result.value(forKey:"title") as! String,
                                          auth: result.value(forKey:"author") as! String,
                                          desc: result.value(forKey:"summary") as! String,
                                          buy: result.value(forKey:"buyUrl") as! String)
                thisModel.userRating = result.value(forKey:"userRating") as! Int
                thisModel.saveState = SaveState(rawValue: result.value(forKey: "saveList") as! Int)!
                booksInModels[thisModel.uid] = thisModel
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            //return [BestSellerListModel]()
        }
        
        return booksInModels
    }
    
    class func saveBook(thisBook: BookModel) {
        print("SAVE BOOK!")
        let entity =  NSEntityDescription.entity(forEntityName: K.CoreData.Entity.BestSellerBook,
                                                 in:K.CoreData.managedContext)
        
        let book = NSManagedObject(entity: entity!,
                                   insertInto: K.CoreData.managedContext)
        
        book.setValue(thisBook.bookTitle, forKey: "title")
        book.setValue(thisBook.author, forKey: "author")
        book.setValue(thisBook.summary, forKey: "summary")
        book.setValue(thisBook.buyURL, forKey: "buyUrl")
        book.setValue(thisBook.uid, forKey: "uid")
        book.setValue(thisBook.userRating, forKey: "userRating")
        book.setValue(thisBook.saveState.rawValue, forKey: "saveList")
        
        print("This book to be saved \(book)")
        do {
            try K.CoreData.managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    class func updateBookWith(saveState: SaveState, uid: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity.BestSellerBook)
        fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
        
        do {
            let fetchResults = try K.CoreData.managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fetchResults?.count != 0{
                
                let managedObject = fetchResults?[0]
                managedObject?.setValue(saveState.rawValue, forKey: "saveList")
                
                do {
                    try K.CoreData.managedContext.save()
                    
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            //return [BestSellerListModel]()
        }
    }
    
    class func updateBookWith(rating: Int, uid: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity.BestSellerBook)
        fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
        
        do {
            let fetchResults = try K.CoreData.managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fetchResults?.count != 0{
                
                let managedObject = fetchResults?[0]
                managedObject?.setValue(rating, forKey: "userRating")
                
                do {
                    try K.CoreData.managedContext.save()
                    
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            //return [BestSellerListModel]()
        }
    }
    
    class func deleteBook(uid: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity.BestSellerBook)
        fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
        
        if let result = try? K.CoreData.managedContext.fetch(fetchRequest) {
            for object in result {
                K.CoreData.managedContext.delete(object as! NSManagedObject)
            }
        }
        
        do {
            try K.CoreData.managedContext.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}

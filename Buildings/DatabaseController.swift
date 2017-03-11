//
//  DatabaseController.swift
//  Databases
//
//  Created by Electronic Armory on 11/2/16.
//  Copyright © 2016 Electronic Armory. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController{
    
    private init(){
        // Can't be called directly
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer? = nil
    
    class func getContext () -> NSManagedObjectContext {
        if( persistentContainer == nil ){
            persistentContainer = NSPersistentContainer(name: "Buildings")
            persistentContainer?.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
        }
        return persistentContainer!.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = DatabaseController.persistentContainer?.viewContext
        if (context?.hasChanges)! {
            do {
                try context?.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

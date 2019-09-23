//
//  CoreDataStack.swift
//  Dev-Libs
//
//  Created by Marc Jacques on 9/23/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        context.performAndWait {
            do {
                try context.save()
            } catch {
                NSLog("Unable to save context: \(error)")
                context.reset()
            }
        }
    }
    
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        
        #warning("change the name below")
        let container = NSPersistentContainer(name: " ")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var mainContext: NSManagedObjectContext { return container.viewContext }
}

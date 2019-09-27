//
//  CoreDataStack.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
   static let shared = CoreDataStack()
   private init() {
   }
    
   lazy var container: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Templates")
       container.loadPersistentStores(completionHandler: { (_, error) in
           if let error = error {
               fatalError("Failed to load persistent stores: \(error)")
           }
       })
       container.viewContext.automaticallyMergesChangesFromParent = true
       return container
   }()
    
   var mainContext: NSManagedObjectContext {
       return container.viewContext
   }
    
   func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
       context.performAndWait {
           do {
               try context.save()
           } catch {
               NSLog("Error saving context: \(error)")
               context.reset()
           }
       }
   }
}

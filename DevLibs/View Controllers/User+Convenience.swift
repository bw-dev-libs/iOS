//
//  User+Convenience.swift
//  DevLibs
//
//  Created by Marc Jacques on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    convenience init(username: String,
                     password: String
        context: NSManagedObjectContext = CoreData.shared.mainContext) {
        
        self.init(context: context)
        
        self.username = username
        self.password = password
    }
    
    convenience init(userRepresentation) {
        <#statements#>
    }
    
    
}

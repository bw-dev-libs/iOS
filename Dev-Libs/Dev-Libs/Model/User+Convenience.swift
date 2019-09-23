//
//  User+Convenience.swift
//  Dev-Libs
//
//  Created by Marc Jacques on 9/23/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import Foundation
import CoreData

extension User{
    convenience init(username: String?,
                     password: String?,
                     identifier: String = UUID().uuidString,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.username = username
        self.password = password
        self.identifier = identifier
    }
    
   convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext) {
        
        guard let title = userRepresentation.username,
            let bodyText = userRepresentation.password,
            let identifier = userRepresentation.identifier else { return nil }
        
        self.init(username: username, password: password, identifier: identifier, context: context)
    }
    
    var userRepresentation: UserRepresentation {
        return UserRepresentation(identifier: identifier, username: username, password: password)
    }
}

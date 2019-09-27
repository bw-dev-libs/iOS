//
//  Template+Convenience.swift
//  DevLibs
//
//  Created by Marc Jacques on 9/26/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation
import CoreData

extension Template {
    
    var templateRepresentation: TemplateRepresentation? {
        guard let programmingLanguage = programmingLanguage,
            let noun = noun,
            let verb = verb,
            let ingVerb = ingVerb,
            let edVerb = edVerb,
            let noun2 = noun2,
            let title = title else { return nil }
        
        
        return TemplateRepresentation(id: UUID(), programmingLanguage: programmingLanguage, noun: noun, verb: verb, ingVerb: ingVerb, edVerb: edVerb, noun2: noun2, title: title)
    }
    convenience init(id: UUID, programmingLanguage: String?, noun: String?, verb: String?, ingVerb: String?, edVerb: String?, noun2: String?, title: String?, context: NSManagedObjectContext) {
        
        // Setting up the generic NSManagedObject functionality of the model object
        // The generic chunk of clay
        self.init(context: context)
        // Once we have the clay, we can begin sculpting it into our unique model object
        self.id = UUID()
        self.programmingLanguage =  programmingLanguage
        self.noun = noun
        self.verb = verb
        self.ingVerb = ingVerb
        self.edVerb = edVerb
        self.noun2 = noun2
        self.title = title
    }
    
    @discardableResult convenience init?(templateRepresentation: TemplateRepresentation, context: NSManagedObjectContext) {
        
        self.init(id: templateRepresentation.id,
                  programmingLanguage: templateRepresentation.programmingLanguage,
                  noun: templateRepresentation.noun,
                  verb: templateRepresentation.verb,
                  ingVerb: templateRepresentation.ingVerb,
                  edVerb: templateRepresentation.edVerb,
                  noun2: templateRepresentation.noun2,
                  title: templateRepresentation.title,
                  context: context)
    }
}

//
//  TemplateRepresentation.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import Foundation

struct TemplateRepresentation: Codable {
    let id: UUID
    let programmingLanguage: String
    let noun: String
    let verb: String
    let ingVerb: String
    let edVerb: String
    let noun2: String
    let title: String
}

//
//  WordController.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import Foundation

class WordController {
    
    private(set) var words: [String]
    
    init() {
        words = []
    }
    
    func addWords(_ incomingNouns: String) {
        words.append(incomingNouns)
    }
    
    func removeElements() {
        words.removeAll()
    }
}

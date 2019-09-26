//
//  WordController.swift
//  DevLibs
//
//  Created by Marc Jacques on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
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

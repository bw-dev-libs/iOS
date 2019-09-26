//
//  StoryController.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/25/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation

class StoryController {
    
    private(set) var stories: [String]
    
    init() {
        stories = []
    }
    
    func addStories(_ incomingStories: String) {
        stories.append(incomingStories)
    }
}

//
//  StoryDetailFromCellViewController.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import UIKit

class StoryDetailFromCellViewController: UIViewController {
    
    // MARK: - Properties
    
    var template: Template? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Outlets

    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var completedStoryTextView: UITextView!
    
    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let template = template,
            let programmingLanguage = template.programmingLanguage,
            let noun = template.noun,
            let verb = template.verb,
            let ingVerb = template.ingVerb,
            let edVerb = template.edVerb,
            let noun2 = template.noun2,
            let title = template.title,
            let completedStoryTextView = completedStoryTextView, let storyTitleLabel = storyTitleLabel else { return }
        
        if isViewLoaded {
            completedStoryTextView.text = "I was programming in \(programmingLanguage), trying to get all of my \(noun) to properly \(verb). However, nothing was actually \(ingVerb)...It was then I realized I hadn't even \(edVerb) my \(noun2)."
            storyTitleLabel.text = title
        }
    }
}

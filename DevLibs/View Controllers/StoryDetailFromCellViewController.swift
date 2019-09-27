//
//  StoryDetailFromCellViewController.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/26/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class StoryDetailFromCellViewController: UIViewController {
    
    var template: Template? {
        didSet {
            updateViews()
        }
    }

    
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    @IBOutlet weak var completedStoryTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

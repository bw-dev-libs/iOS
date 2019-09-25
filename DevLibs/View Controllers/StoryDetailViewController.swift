//
//  StoryDetailViewController.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController {
    
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    @IBOutlet weak var completedStoryTextView: UITextView!
    
    var currentState = GameState(rawValue: "detail")
    
    var wordController: WordController?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let wordController = wordController else { return }
        guard let completedStoryTextView = completedStoryTextView, let storyTitleLabel = storyTitleLabel else { return }
        completedStoryTextView.text = "I was programming in \(wordController.words[0]), trying to get all of my \(wordController.words[1]) to properly \(wordController.words[2]). However, nothing was actually _____...It was then I realized I hadn't even _____ my _____."
        storyTitleLabel.text = wordController.words[3]
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

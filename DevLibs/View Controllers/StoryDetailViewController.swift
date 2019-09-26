//
//  StoryDetailViewController.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation
import UIKit

class StoryDetailViewController: UIViewController {
    
    @IBOutlet weak var storyTitleLabel: UILabel!
    
    @IBOutlet weak var completedStoryTextView: UITextView!
    
    var currentState = GameState(rawValue: "detail")
    
    var wordController: WordController?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let wordController = wordController else { return }
        guard let completedStoryTextView = completedStoryTextView, let storyTitleLabel = storyTitleLabel else { return }
        completedStoryTextView.text = "I was programming in \(wordController.words[0]), trying to get all of my \(wordController.words[1]) to properly \(wordController.words[2]). However, nothing was actually \(wordController.words[3])...It was then I realized I hadn't even \(wordController.words[4]) my \(wordController.words[5])."
        storyTitleLabel.text = wordController.words[6]
    }
    
    @IBAction func DoneButtonTapped(_ sender: UIButton) {
        let dashboardVC = navigationController!.viewControllers.filter { $0 is DashboardViewController }.first!
        navigationController!.popToViewController(dashboardVC, animated: true)
        wordController?.removeElements()
    }
}

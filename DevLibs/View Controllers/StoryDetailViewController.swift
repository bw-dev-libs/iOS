//
//  StoryDetailViewController.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import Foundation
import UIKit

class StoryDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var apiController = APIController()
    var currentState = GameState(rawValue: "detail")
    var wordController: WordController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var completedStoryTextView: UITextView!
    
    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        self.navigationItem.hidesBackButton = true
    }
    
    func updateViews() {
        guard let wordController = wordController else { return }
        guard let completedStoryTextView = completedStoryTextView, let storyTitleLabel = storyTitleLabel else { return }
        completedStoryTextView.text = "I was programming in \(wordController.words[0]), trying to get all of my \(wordController.words[1]) to properly \(wordController.words[2]). However, nothing was actually \(wordController.words[3])...It was then I realized I hadn't even \(wordController.words[4]) my \(wordController.words[5])."
        storyTitleLabel.text = wordController.words[6]
    }
    
    // MARK: - Navigation
    
    @IBAction func DoneButtonTapped(_ sender: UIButton) {
        guard let wordController = wordController else { return }
        let _ = apiController.createTemplate(id: UUID(), programmingLanguage: wordController.words[0], noun: wordController.words[1], verb: wordController.words[2], ingVerb: wordController.words[3], edVerb: wordController.words[4], noun2: wordController.words[5], title: wordController.words[6])
        //wordController.removeElements()
        let dashboardVC = navigationController!.viewControllers.filter { $0 is DashboardViewController }.first!
        navigationController!.popToViewController(dashboardVC, animated: true)
    }
}

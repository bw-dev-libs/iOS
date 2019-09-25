//
//  GameViewController.swift
//  DevLibs
//
//  Created by Marc Jacques on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

enum GameState: String {
    case noun = "noun", verb, adjective, title, detail
}

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var mainTextField: UITextField!
    
    let toStoryView1 = "SegueToStoryView1"
    let toStoryView2 = "SegueToStoryView2"
    let toStoryView3 = "SegueToStoryView3"
    let toStoryViewTitle = "SegueToStoryViewTitle"
    let toStoryViewDetail = "SegueToStoryViewDetail"
    
    var wordController: WordController?

    var currentState: GameState = .noun

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitPOSButtonTapped(_ sender: UIButton) {
        guard let word = mainTextField.text else { return }
        
        if !word.isEmpty {
            guard let wordController = wordController else { return }
            wordController.addWords(word)
            #warning("save to core data")
            
            switch currentState {
                case .noun:
                    currentState = .verb
                    self.performSegue(withIdentifier: toStoryView2, sender: self)
                case .verb:
                    currentState = .adjective
                    self.performSegue(withIdentifier: toStoryView3, sender: self)
                case .adjective:
                    currentState = .title
                    self.performSegue(withIdentifier: toStoryViewTitle, sender: self)
                case .title:
                    currentState = .detail
                    self.performSegue(withIdentifier: toStoryViewDetail, sender: self)
                default:
                    return
            }
        } else {
            //wordController.addWords(" ")
            //alert
            print("no word")
            #warning("save to core data")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let wordController = wordController else { return }
        if segue.identifier == toStoryView2 {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .verb
        }
        if segue.identifier == toStoryView3 {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .adjective
        }
        if segue.identifier == toStoryViewTitle {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .title
        }
        if segue.identifier == toStoryViewDetail {
            guard let destination = segue.destination as? StoryDetailViewController else { return }
            destination.wordController = wordController
            destination.currentState = .detail
        }
    }
}

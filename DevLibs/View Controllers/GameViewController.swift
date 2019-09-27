//
//  GameViewController.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

enum GameState: String {
    case programmingLanguage = "programmingLanguage", noun, verb, ingVerb, edVerb, noun2, title, detail
}

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    let toStoryView1 = "SegueToStoryView1"
    let toStoryView2 = "SegueToStoryView2"
    let toStoryView3 = "SegueToStoryView3"
    let toStoryView4 = "SegueToStoryView4"
    let toStoryView5 = "SegueToStoryView5"
    let toStoryView6 = "SegueToStoryView6"
    let toStoryViewTitle = "SegueToStoryViewTitle"
    let toStoryViewDetail = "SegueToStoryViewDetail"
        
    var wordController: WordController?
    
    var currentState: GameState = .programmingLanguage
    
    // MARK: - Outlets
    
    @IBOutlet weak var mainTextField: UITextField!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextField.delegate = self
    }
    
    // MARK: - Navigation
    
    @IBAction func submitPOSButtonTapped(_ sender: UIButton) {
        guard let word = mainTextField.text else { return }
        
        if !word.isEmpty {
            guard let wordController = wordController else { return }
            wordController.addWords(word)
            
            switch currentState {
            case .programmingLanguage:
                currentState = .noun
                self.performSegue(withIdentifier: toStoryView2, sender: self)
            case .noun:
                currentState = .verb
                self.performSegue(withIdentifier: toStoryView3, sender: self)
            case .verb:
                currentState = .ingVerb
                self.performSegue(withIdentifier: toStoryView4, sender: self)
            case .ingVerb:
                currentState = .edVerb
                self.performSegue(withIdentifier: toStoryView5, sender: self)
            case .edVerb:
                currentState = .noun2
                self.performSegue(withIdentifier: toStoryView6, sender: self)
            case .noun2:
                currentState = .title
                self.performSegue(withIdentifier: toStoryViewTitle, sender: self)
            case .title:
                currentState = .detail
                self.performSegue(withIdentifier: toStoryViewDetail, sender: self)
            default:
                return
            }
        } else {
            let alert = UIAlertController(title: "No word entered", message: "Please enter a word.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true) {
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let wordController = wordController else { return }
        if segue.identifier == toStoryView2 {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .noun
        }
        if segue.identifier == toStoryView3 {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .verb
        }
        if segue.identifier == toStoryView4 {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .ingVerb
        }
        if segue.identifier == toStoryView5 {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .edVerb
        }
        if segue.identifier == toStoryView6 {
            guard let destination = segue.destination as? GameViewController else { return }
            destination.wordController = wordController
            destination.currentState = .noun2
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

// MARK: - Text Field Delegate

extension GameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mainTextField {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
}

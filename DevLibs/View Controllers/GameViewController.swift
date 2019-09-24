//
//  GameViewController.swift
//  DevLibs
//
//  Created by Marc Jacques on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //    @IBOutlet weak var noun1TextField: UITextField!
    //    @IBOutlet weak var verb1TextField: UITextField!
    //    @IBOutlet weak var adjective1TextField: UITextField!
    @IBOutlet weak var storyTitleTextField: UITextField!
    @IBOutlet weak var mainTextField: UITextField!
    
    let toGameView1 = "SegueToGameview1"
    let toGameView2 = "SegueToGameview2"
    let toGameView3 = "SegueToGameview3"
    let toStoryTitlePage = "SegueToGameviewTitle"
    
    let wordController = WordController()
    
    var segueShouldOccur: Bool = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func submitPOSButtonTapped(_ sender: UIButton) {
    
        guard let word = mainTextField.text else { return }
//        guard let title = storyTitleTextField.text else { return }
        
        if !word.isEmpty {
            wordController.addWords(word)
            #warning("save to core data")
        } else {
            wordController.addWords(" ")
            #warning("save to core data")
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

//
//  GameViewController.swift
//  DevLibs
//
//  Created by Marc Jacques on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

  @IBOutlet weak var noun1TextField: UITextField!
    @IBOutlet weak var verb1TextField: UITextField!
    @IBOutlet weak var adjective1TextField: UITextField!
    @IBOutlet weak var storyTitleTextField: UITextField!
    
    var POSArray: [String] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func submitPOSButtonTapped(_ sender: UIButton) {
        //guard let noun1TextField = noun1TextField.text else { return }
        //POSArray.append(noun1TextField)
        #warning("Append each POS text field to Array")
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

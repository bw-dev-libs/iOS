//
//  DashboardViewController.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    let toStoryView1 = "SegueToStoryView1"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    
    @IBAction func addStoryButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: toStoryView1, sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toStoryView1 {
            guard let destination = segue.destination as? GameViewController else { return }
            let wordController = WordController()
            destination.wordController = wordController
        }
    }
}

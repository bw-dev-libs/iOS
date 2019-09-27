//
//  DashboardTableViewCell.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    // MARK: - Properties
   
    let segueToDetail = "SegueToStoryViewDetailFromCell"
    
    var template: Template? { //define model for the cell
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Functions

    func updateViews() {
        guard let template = template else { return }
        titleLabel.text = template.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//
//  DashboardTableViewCell.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
   
    let segueToDetail = "SegueToStoryViewDetailFromCell"
    
    var template: Template? { //define model for the cell
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func updateViews() {
        guard let template = template else { return }
        
        titleLabel.text = template.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

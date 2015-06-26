//
//  MediaCell.swift
//  myTasks
//
//  Created by Fernando on 6/22/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
    
    @IBOutlet weak var mediaLabel: UILabel!
    
    @IBOutlet weak var porcentLabel: UILabel!
    
    @IBOutlet weak var nomeDiscLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

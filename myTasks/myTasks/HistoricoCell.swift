//
//  HistoricoCell.swift
//  myTasks
//
//  Created by Fernando on 6/22/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import UIKit

class HistoricoCell: UITableViewCell {

    @IBOutlet weak var nomeLabel: UILabel!
    
    @IBOutlet weak var disciplinaLabel: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

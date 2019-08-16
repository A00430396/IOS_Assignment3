//
//  TableViewCellController.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-20.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit

class TableViewCellController: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  cellViewExtdTableViewCell.swift
//  TableCustomRow
//
//  Created by boby thomas on 2015-06-09.
//  Copyright (c) 2015 boby thomas. All rights reserved.
//

import UIKit

class UserDetailsCell: UITableViewCell {

    var name: String = "" {
        didSet {
        if (name != oldValue) {
        nameLabel.text = name
        }
        }
    }
    var details: String = "" {
        didSet {
        if (details != oldValue) {
        detailsLabel.text = details
        }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var m_imgPerson: UIImageView!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

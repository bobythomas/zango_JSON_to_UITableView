//
//  DetailsTableViewCell.swift
//  zango
//
//  Created by boby thomas on 2015-09-18.
//  Copyright (c) 2015 boby thomas. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var m_UITextArea: UILabel!
    
    var m_text : String = ""
    {
        didSet{
            if(m_text != oldValue){
                m_UITextArea.text = m_text
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

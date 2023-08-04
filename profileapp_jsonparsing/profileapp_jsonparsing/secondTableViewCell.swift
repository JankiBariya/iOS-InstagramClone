//
//  secondTableViewCell.swift
//  profileapp_jsonparsing
//
//  Created by PMCLAP1240 on 03/02/23.
//

import UIKit

class secondTableViewCell: UITableViewCell {

    @IBOutlet weak var outputFollowersLabel: UILabel!
    
    @IBOutlet weak var imgView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView2.layer.cornerRadius = imgView2.frame.size.width/2
        
        imgView2.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

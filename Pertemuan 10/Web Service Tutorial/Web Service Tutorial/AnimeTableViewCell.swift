//
//  AnimeTableViewCell.swift
//  Web Service Tutorial
//
//  Created by Ario on 09/01/23.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {
    @IBOutlet var animeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

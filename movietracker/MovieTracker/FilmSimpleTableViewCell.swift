//
//  FilmSimpleTableViewCell.swift
//  MovieTracker
//
//  Created by Tolkachev Nikita on 21.05.2018.
//  Copyright © 2018 tolkachev. All rights reserved.
//

import UIKit

class FilmSimpleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filmPosterImage: UIImageView!
    @IBOutlet weak var filmLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

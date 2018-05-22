//
//  FilmFavouriteTableViewCell.swift
//  MovieTracker
//
//  Created by Tolkachev Nikita on 22.05.2018.
//  Copyright © 2018 tolkachev. All rights reserved.
//

import UIKit

class FilmFavouriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filmPosterImage: UIImageView!
    @IBOutlet weak var filmLabel: UILabel!
    @IBOutlet weak var isWatchedImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

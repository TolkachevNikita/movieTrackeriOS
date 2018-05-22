//
//  Models.swift
//  MovieTracker
//
//  Created by Tolkachev Nikita on 21.05.2018.
//  Copyright © 2018 tolkachev. All rights reserved.
//

import Foundation

class FilmModel {

    let id: Int
    let title: String
    let image: String
    let releaseDate: String

    init(id: Int, title: String, image: String, releaseDate: String) {
        self.id = id
        self.title = title
        self.image = "https://image.tmdb.org/t/p/w500\(image)"
        self.releaseDate = releaseDate
    }

}

class FilmDetailModel {

    let title: String
    let image: String
    let releaseDate: String
    let overview: String

    init(title: String, image: String, releaseDate: String, overview: String) {
        self.title = title
        self.image = "https://image.tmdb.org/t/p/w500\(image)"
        self.releaseDate = releaseDate
        self.overview = overview
    }

}

//
//  FilmsInteractor.swift
//  MovieTracker
//
//  Created by Tolkachev Nikita on 21.05.2018.
//  Copyright © 2018 tolkachev. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift

class FilmsInteractor {

    func search(searchText: String) -> Observable<Array<FilmModel>> {
        let url = "https://api.themoviedb.org/3/search/movie?query=\(searchText)&api_key=b7c5b3c41053880dab8271e0fa4864da&language=ru"

        return requestJSON(.get, url)
                .debug()
                .map { response, json -> Array<FilmModel> in

                    if let root = json as? [String: AnyObject] {
                        let results = root["results"] as! [AnyObject]

                        return results.map { raw -> FilmModel in
                            print(raw)

                            let r = raw as! Dictionary<String, AnyObject>
                            return FilmModel(id: r["id"] as! Int, title: r["title"] as! String, image: r["poster_path"] as? String ?? "", releaseDate: r["release_date"] as! String)
                        }
                    }

                    return []
                }
    }

    func detailFilm(filmId: Int) -> Observable<FilmDetailModel?> {
        let url = "https://api.themoviedb.org/3/movie/\(filmId)?api_key=b7c5b3c41053880dab8271e0fa4864da&language=ru"

        return requestJSON(.get, url)
                .map { response, json -> FilmDetailModel? in
                    if let root = json as? [String: Any] {

                        return FilmDetailModel(
                                title: root["title"] as! String,
                                image: root["poster_path"] as? String ?? "",
                                releaseDate: root["release_date"] as! String,
                                overview: root["overview"] as! String
                        )
                    }

                    return nil
                }
    }

}

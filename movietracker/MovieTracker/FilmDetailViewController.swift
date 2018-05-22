//
//  FilmDetailViewController.swift
//  MovieTracker
//
//  Created by Tolkachev Nikita on 21.05.2018.
//  Copyright © 2018 tolkachev. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class FilmDetailViewController: UIViewController {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overViewLabel: UILabel!

//    var filmId: Int = 0
    var filmId: Int = 383498
    let filmsInteractor = FilmsInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()

        indicatorView.isHidden = false
        scrollView.isHidden = true


        filmsInteractor.detailFilm(filmId: filmId)
                .subscribe(onNext: { model in
                    self.title = model?.title

                    let url = URL(string: model?.image ?? "")!
                    let date = model?.releaseDate ?? "2018"

                    self.filmNameLabel.text = model?.title
                    self.yearLabel.text = String(date.prefix(4))
                    self.posterImage.kf.setImage(with: url)
                    self.overViewLabel.text = model?.overview

                    self.indicatorView.isHidden = true
                    self.scrollView.isHidden = false

                }, onError: {
                    error in
                    print(error.localizedDescription)
                })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

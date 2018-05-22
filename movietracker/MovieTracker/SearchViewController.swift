//
//  SearchViewController.swift
//  MovieTracker
//
//  Created by Tolkachev Nikita on 21.05.2018.
//  Copyright © 2018 tolkachev. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!

    let filmsInteractor = FilmsInteractor()
    var items: Array<FilmModel> = []
    var filmId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "film_simple_cell") as! FilmSimpleTableViewCell
        let model = items[indexPath.row]

        let url = URL(string: model.image)!

        cell.filmLabel.text = model.title
        cell.filmPosterImage.kf.setImage(with: url)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filmId = items[indexPath.row].id
        performSegue(withIdentifier: "film_detail_segue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "film_detail_segue" {
            let controller = segue.destination as! FilmDetailViewController
            controller.filmId = filmId
        }
    }

    @IBAction func onSearchClick(_ sender: Any) {

        filmsInteractor.search(searchText: searchField.text!)
                .subscribe(onNext: { items in
                    self.items = items
                    self.tableView.reloadData()

                }, onError: { error in print(error.localizedDescription) })
    }

    @IBAction func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let point = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: point) {
                let filmModel = items[indexPath.row]

                let alert = UIAlertController(title: "Внимание", message: "Добавить в избраное?", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Добавить", style: UIAlertActionStyle.default, handler: { _ in
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    let filmEntity = FilmEntity(context: context)
                    
                    filmEntity.filmId = Int32(filmModel.id)
                    filmEntity.isWatched = false
                    filmEntity.poster = filmModel.image
                    filmEntity.title = filmModel.title
                    filmEntity.releaseDate = filmModel.releaseDate
                    
                    appDelegate.saveContext()
                }))
                
                self.present(alert, animated: true, completion: nil)
            }

        }
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

//
//  ViewController.swift
//  MovieTracker
//
//  Created by Tolkachev Nikita on 21.05.2018.
//  Copyright © 2018 tolkachev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var result: [FilmEntity] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadData()
    }

    private func reloadData() {

        let context = appDelegate.persistentContainer.viewContext

        do {
            result = try context.fetch(FilmEntity.fetchRequest())
            tableView.reloadData()

        } catch {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "film_simple_cell") as! FilmFavouriteTableViewCell
        let entity = result[indexPath.row]

        let date = entity.releaseDate ?? "2018"
        let year = String(date.prefix(4))

        cell.filmLabel.text = "\(entity.title) (\(year))"

        let url = URL(string: entity.poster ?? "")!
        cell.filmPosterImage.kf.setImage(with: url)


        if entity.isWatched {
            cell.isWatchedImage.image = UIImage(named: "check")
        } else {
            cell.isWatchedImage.image = UIImage(named: "uncheck")
        }


        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let filmEntity = result[indexPath.row]
        let checkText = filmEntity.isWatched ? "Не просмотрен" : "Просмотрен"

        let alert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: nil))

        alert.addAction(UIAlertAction(title: checkText, style: UIAlertActionStyle.destructive, handler: { _ in
            filmEntity.isWatched = !filmEntity.isWatched
            self.appDelegate.saveContext()


            self.reloadData()

        }))
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertActionStyle.default, handler: { _ in

            let context = self.appDelegate.persistentContainer.viewContext
            context.delete(filmEntity)
            self.appDelegate.saveContext()

            self.reloadData()
        }))

        self.present(alert, animated: true, completion: nil)

    }

}


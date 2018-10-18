//
//  GenresViewController.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import UIKit

class GenresViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var genres: [Genre]!
    var loader: DMLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = DMLoader(view: self.view)
        loader.start()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sendRequest()
        
    }
    
    func sendRequest() {
        APIClient.getGenres { (result, error) in
            if let res = result {
                self.genres = res
                self.tableView.reloadData()
                self.loader.stop()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "genreMoviesSegue" {
            let index = sender as! Int
            let upcoming = segue.destination as! MoviesViewController
            upcoming.genreId = genres[index].id
            upcoming.title = genres[index].name
        }
    }
}

extension GenresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = genres?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenreTableViewCell
        
        let current = genres[indexPath.row]
        
        cell.genreLabel.text = current.name!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "genreMoviesSegue", sender: indexPath.row)
    }
    
    
}

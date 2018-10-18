//
//  FilmsViewController.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import UIKit

class FilmCategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [FilmCategories]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categories = [
            FilmCategories(categoryName: "Популярные", categoryImage: "star", engCategoryName: "popular"),
            FilmCategories(categoryName: "Скоро на экранах", categoryImage: "timer", engCategoryName: "upcoming"),
            FilmCategories(categoryName: "Самые оцениваемые", categoryImage: "thumbs_up", engCategoryName: "top_rated")
        ]

    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMoviesSegue" {
            let index = sender as! Int
            let upcoming = segue.destination as! MoviesViewController
            upcoming.movieCategory = categories[index]
        }
    }
}

extension FilmCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCategory", for: indexPath) as! CategoryFilmsTableViewCell
        
        let current = categories[indexPath.row]
        
        cell.categoryLabel.text = current.categoryName
        cell.categoryImage.image = UIImage(named: current.categoryImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMoviesSegue", sender: indexPath.row)
    }
    
}

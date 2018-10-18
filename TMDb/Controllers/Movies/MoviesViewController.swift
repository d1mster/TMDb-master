//
//  MoviesViewController.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieCategory: FilmCategories!
    var moviesList: MoviesList?
    var loader: DMLoader!
    var genreId: Int?
    var filteredMovies: [Movie]?
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchSetup()
        
        loader = DMLoader(view: self.view)
        loader.start()
        
        if genreId == nil {
            self.title = movieCategory.categoryName
        }
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sendRequest()
        
    }
    
    func searchSetup() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск фильмов"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = moviesList?.movies!.filter({( movies : Movie) -> Bool in
            return movies.title!.lowercased().contains(searchText.lowercased())
        })
        sendFilteredRequest(text: searchText)
        collectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func sendFilteredRequest(text: String) {
        APIClient.searchMovie(text: text) { (result, error) in
            if let res = result {
                self.moviesList?.movies = res
                self.collectionView.reloadData()
            }
        }
    }
    
    func sendRequest() {
        
        if genreId == nil {
            APIClient.getMovies(type: movieCategory.engCategoryName) { (result, error) in
                if let res = result {
                    self.moviesList = res
                    self.collectionView.reloadData()
                    self.loader.stop()
                }
            }
        } else {
            APIClient.getByGenres(genreId: genreId!) { (result, error) in
                if let res = result {
                    self.moviesList = MoviesList()
                    self.moviesList!.movies = res
                    self.collectionView.reloadData()
                    self.loader.stop()
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieSegue" {
            let index = sender as! Int
            let upcoming = segue.destination as! MovieInfoViewController
            upcoming.movieId = moviesList?.movies![index].id
        }
    }

}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies!.count
        }
        
        guard let list = moviesList else { return 0 }
        return (list.movies?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCollectionViewCell
        let current: Movie!
        
        if isFiltering() {
            current = filteredMovies![indexPath.row]
        } else {
            current = moviesList?.movies![indexPath.row]
        }
        
        cell.ratingLabel.text = "\(String(describing: current.voteAverage!))"
        cell.movieImage.kf.indicatorType = .activity
        if current?.posterPath != nil {
            cell.movieImage.kf.setImage(with: URL(string: (current?.posterPath?.convertToURL())!))
        } else {
            cell.movieImage.image = Helper.current.imagePlaceholder
        }
        
        cell.nameLabel.text = current?.title

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat((collectionView.frame.size.width / 2) - 40)
        let height = CGFloat((((collectionView.frame.size.width / 2) - 40) * 2) - 20)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMovieSegue", sender: indexPath.row)
    }
}

extension MoviesViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

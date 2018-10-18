//
//  MovieInfoViewController.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import UIKit
import Kingfisher
import SimpleImageViewer

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var movieBudget: UILabel!
    @IBOutlet weak var movieRevenue: UILabel!
    
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var relatedMoviesCollectionView: UICollectionView!
    
    var movieId: Int!
    var movie: MovieAbout!
    var actors: [Actors]!
    var images: Images!
    var similar: SimilarMovies!
    var loader: DMLoader!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loader = DMLoader(view: self.view)
        loader.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = " "
        
        
        
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
        
        relatedMoviesCollectionView.delegate = self
        relatedMoviesCollectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sendRequest()
    }
    
    func sendRequest() {
        if let id = movieId {
            APIClient.getMovie(movieId: "\(id)") { (result, error) in
                if let res = result {
                    self.movie = res
                    if self.movie!.posterPath != nil {
                        self.movieImage.kf.setImage(with: URL(string: (self.movie.posterPath?.convertToURL())!))
                    }
                    
                    self.movieLabel.text = self.movie.title
                    self.movieRating.text = "\(String(describing: self.movie.voteAverage!))"
                    var genres: String = ""
                    for current in self.movie!.genres! {
                        genres.append(current.name!)
                        genres.append(", ")
                    }
                    genres.removeLast()
                    genres.removeLast()
                    if self.movie!.budget != nil {
                        self.movieBudget.text = "\(self.movie!.budget!)$"
                    }
                    
                    if self.movie!.revenue != nil {
                        self.movieRevenue.text = "\(self.movie!.revenue!)$"
                    }
                    
                    if self.movie!.tagline != "" || self.movie!.tagline != nil {
                         self.tagline.text = self.movie!.tagline!
                    }
                   
                    self.movieGenres.text = genres
                    if self.movie!.runtime != nil {
                         self.movieRuntime.text = "\(self.movie!.runtime!) минут"
                    }
                    
                    if self.movie!.releaseDate != nil {
                        self.movieDate.text = self.movie!.releaseDate?.getDatefromTimeStamp(strdateFormat: "dd.MM.YYYY")
                    }
                    self.tableView.reloadData()
                    self.loader.stop()
                }
            }
            
            APIClient.getActors(movieId: "\(id)") { (result, error) in
                if let res = result {
                    self.actors = res
                    self.actorsCollectionView.reloadData()
                }
            }
            
            APIClient.getImages(movieId: "\(id)") { (result, error) in
                if let res = result {
                    self.images = res
                    self.imagesCollectionView.reloadData()
                }
            }
            
            APIClient.getSimilar(movieId: "\(id)") { (result, error) in
                if let res = result {
                    self.similar = res
                    
                    self.relatedMoviesCollectionView.reloadData()
                }
            }
        }
       
    }

    

}

extension MovieInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as! AboutMovieTableViewCell
        if self.movie?.overview != nil {
             cell.aboutLabel.text = self.movie!.overview!
        }
       
        
        return cell
    }
    
    
}

extension MovieInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            guard let count = actors?.count else { return 0 }
            return count
        }
        if collectionView.tag == 1 {
            guard let count = images?.backdrops?.count else { return 0 }
            return count
        }
        if collectionView.tag == 2 {
            guard let count = similar?.movies?.count else { return 0 }
            return count
        }
        
      return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 || collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actorCell", for: indexPath) as! ActorCollectionViewCell
            
             cell.actorImage.kf.indicatorType = .activity
            
            if collectionView.tag == 2 {
                let current = similar.movies?[indexPath.row]
                cell.actorImage.kf.setImage(with: URL(string: (current?.posterPath?.convertToURL())!))
                cell.actorName.text = current?.title
            }
            
            
            
            if collectionView.tag == 0 {
                let current = actors[indexPath.row]
                if current.profilePath != nil {
                    cell.actorImage.kf.setImage(with: URL(string: (current.profilePath?.convertToURL())!))
                } else {
                    cell.actorImage.image = Helper.current.imagePlaceholder
                }
                cell.actorName.text = current.name!
                cell.characterName.text = current.character!
            }
            
            
            return cell
        }
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
            
            let current = images.backdrops?[indexPath.row]
            
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: URL(string: (current!.filePath?.convertToURL())!))
            
            return cell
        }
         return UICollectionViewCell()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! ActorCollectionViewCell
            if actors[indexPath.row].profilePath != nil {
                let configuration = ImageViewerConfiguration { config in
                    config.imageView = cell.actorImage
                }
                
                present(ImageViewerController(configuration: configuration), animated: true)
            }
           
        }
        
        if collectionView.tag == 1 {
            let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
            
            let configuration = ImageViewerConfiguration { config in
                config.imageView = cell.imageView
            }
            
            present(ImageViewerController(configuration: configuration), animated: true)
        }
        
        if collectionView.tag == 2 {
            let current = similar.movies?[indexPath.row]
            
            let destination:MovieInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "id1") as! MovieInfoViewController
            destination.movieId = current!.id
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
}

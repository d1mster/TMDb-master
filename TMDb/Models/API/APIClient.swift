//
//  APIRouter.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct APIClient {
    
    typealias MoviesListResponse = (_ regions: MoviesList?, _ error: APIError?) -> Void
    typealias MovieListResponse = (_ regions: MovieAbout?, _ error: APIError?) -> Void
    typealias ActorListResponse = (_ regions: [Actors]?, _ error: APIError?) -> Void
    typealias MovieImagesResponse = (_ regions: Images?, _ error: APIError?) -> Void
    typealias SimilarMoviesResponse = (_ regions: SimilarMovies?, _ error: APIError?) -> Void
    typealias GenreResponse = (_ regions: [Genre]?, _ error: APIError?) -> Void
    typealias MoviesByGenreResponse = (_ regions: [Movie]?, _ error: APIError?) -> Void
    typealias SearchMoviesResponse = (_ regions: [Movie]?, _ error: APIError?) -> Void
    
    static public func getMovies(type: String, _ completion: @escaping MoviesListResponse) {
        
        AF.manager.request(APIRouter.getMoviesList(type))
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseObject { (response: DataResponse<MoviesList>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
    static public func getMovie(movieId: String, _ completion: @escaping MovieListResponse) {
        
        AF.manager.request(APIRouter.getMovie(movieId))
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseObject { (response: DataResponse<MovieAbout>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
    static public func getActors(movieId: String, _ completion: @escaping ActorListResponse) {
        
        AF.manager.request(APIRouter.getActors(movieId))
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseArray(keyPath: "cast") { (response: DataResponse<[Actors]>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
    static public func getImages(movieId: String, _ completion: @escaping MovieImagesResponse) {
        
        AF.manager.request(APIRouter.getImages(movieId))
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseObject { (response: DataResponse<Images>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
    static public func getSimilar(movieId: String, _ completion: @escaping SimilarMoviesResponse) {
        
        AF.manager.request(APIRouter.getSimilar(movieId))
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseObject { (response: DataResponse<SimilarMovies>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
    static public func getGenres( _ completion: @escaping GenreResponse) {
        
        AF.manager.request(APIRouter.getGenres)
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseArray(keyPath: "genres") { (response: DataResponse<[Genre]>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
    static public func getByGenres(genreId: Int, _ completion: @escaping MoviesByGenreResponse) {
        
        AF.manager.request(APIRouter.getByGenres(genreId))
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
    static public func searchMovie(text: String, _ completion: @escaping MoviesByGenreResponse) {
        
        AF.manager.request(APIRouter.searchMovie(text))
            .log(.verbose)
            .responseJSON { res in
                if let error = checkResponse(response: res){
                    if error != ""{
                        completion(nil, APIError(error))
                    }
                }
            }
            .responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
                if let result = response.result.value {
                    completion(result, nil)
                }
        }
        
    }
    
}

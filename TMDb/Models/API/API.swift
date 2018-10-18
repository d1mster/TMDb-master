//
//  API.swift
//  TMDb
//
//  Created by Dmitriy Pak on 10/17/18.
//  Copyright © 2018 Dmitriy Pak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum APIRouter: URLRequestConvertible {
    
    private static let baseUrl = "https://api.themoviedb.org/3/"
    
    var apiKey: String {
        return "02da584cad2ae31b564d940582770598"
    }
    
    var language: String {
        return "ru-RU"
    }
    
    
    case getMoviesList(String), getMovie(String), getActors(String), getImages(String), getSimilar(String), getGenres, getByGenres(Int), searchMovie(String)
    
    var method: HTTPMethod {
        
        switch self {
        case .getMoviesList, .getMovie, .getActors, .getImages, .getSimilar, .getGenres, .getByGenres, .searchMovie:
            return .get
            
        }
        
    }
    
    var path: String {
        
        switch self {
        case .getMoviesList(let type), .getMovie(let type):
            return "movie/\(type)"
        case .getActors(let movieId):
            return "movie/\(movieId)/credits"
        case .getImages(let movieId):
            return "movie/\(movieId)/images"
        case .getSimilar(let movieId):
            return "movie/\(movieId)/similar"
        case .getGenres:
            return "genre/movie/list"
        case .getByGenres:
            return "discover/movie"
        case .searchMovie:
            return "search/movie"
        }
        
        
    }
    
    var parameters: [String: Any] {
        
        switch self {
        case .getMoviesList, .getMovie, .getActors, .getSimilar, .getGenres:
            return ["api_key": apiKey, "language": language]
        case .getImages:
            return ["api_key": apiKey]
        case .getByGenres(let genreId):
            return ["api_key": apiKey, "language": language, "with_genres": genreId]
        case .searchMovie(let query):
            return ["api_key": apiKey, "language": language, "query": query]
        }
    }
    
    public func addAuthHeader(_ request: inout URLRequest) {
    
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        switch self {
            
            
        default:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            addAuthHeader(&request)
            
            if method == .post {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = data
                return try URLEncoding.default.encode(request, with: nil)
            }
            
            return try URLEncoding.default.encode(request, with: parameters)
        }
        
    }
    
    
}

public struct APIError{
    var code: String = ""
    var errorDescription: String{
        return code
    }
    
    init(_ code: String){
        self.code = code
    }
}


public func checkResponse(response: DataResponse<Any>) -> String? {
    
    guard let code = response.response?.statusCode, let _ = response.response?.allHeaderFields else {
        return "notResponse"
    }

    
    if let _ = response.result.value{
        var json = JSON(response.data!)
        
        if json["error"].stringValue != ""{
            
            let errString = json["error"].stringValue
            
            if (APIError(errString).errorDescription == errString){
                return json["error"].stringValue
            }
            
            return errString
            
        }
    }
    
    if code > 203{
        return "\(code)"
    }
    
    
    
    
    return nil
}



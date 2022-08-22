//
//  Configuration.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 20.08.2022.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

struct Configuration {
    struct ProductionServer {
        static let baseURL =  "https://api.themoviedb.org/3/movie/popular"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

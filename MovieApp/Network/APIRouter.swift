//
//  APIRouter.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 21.08.2022.
//

import Foundation
import Alamofire

enum ApiRouter : APIConfiguration {
    case getMovies(pageNumber: Int)
}

extension ApiRouter {
    var path: String {
        switch self {
        case .getMovies(let pageNumber):
            return "\(pageNumber)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies:
            return .get
        }
    }
    
    // Don't need parameters for get methods
    var parameters: Parameters?{
        switch self {
        case .getMovies:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Configuration.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        //Get query parameters
        var queryItems = [URLQueryItem]()
        
        //APikey
        let apikeyParameter = URLQueryItem(name: "api_key", value: AppConstants.apiKey)
        queryItems.append(apikeyParameter)
        
        let pagination = URLQueryItem(name: "page", value: path)
        queryItems.append(pagination)

        // Parameters
        if method == .get  {
            if let parameters = parameters {
                for key in parameters.keys {
                    let queryParameter = URLQueryItem(name: key, value: parameters[key] as? String)
                    queryItems.append(queryParameter)
                }
            }
        } else {
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
        }
        //add queryItems to urlRequest
        var urlComps = URLComponents(string: urlRequest.url!.absoluteString)!
        urlComps.queryItems = queryItems
        urlRequest.url = urlComps.url
        
        debugPrint("Request:::\(urlRequest.url?.absoluteString ?? "")")
        
        return urlRequest
    }
    
}


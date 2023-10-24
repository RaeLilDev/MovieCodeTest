//
//  Endpoint.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import Alamofire

enum Endpoint {
    
    case popularMovies(Int)
    
    case upcomingMovies(Int)
    
    var headers: HTTPHeaders? {
        [
            "Accept": "application/json",
            "Authorization": "Bearer \(ApiConstants.accessToken)"
        ]
    }
    
    var attribute: EndpointAttribute {
        switch self {
        case .popularMovies(let page):
            return .init(path: "/movie/popular?language=en-US&page=\(page)", method: .get, encoding: .json)
            
        case .upcomingMovies(let page):
            return .init(path: "/movie/upcoming?language=en-US&\(page)", method: .get, encoding: .json)
        }
    }
    
}

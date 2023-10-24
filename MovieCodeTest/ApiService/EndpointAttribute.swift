//
//  EndpointAttribute.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import Alamofire

enum Encoding {
    case query
    case json
    case none
}

struct EndpointAttribute {
    
    var route: String
    var method: HTTPMethod
    var encoding: ParameterEncoding
    
    init(path: String, method: HTTPMethod, encoding: Encoding) {
        self.route = ApiConstants.baseUrl + ApiConstants.version + path
        self.method = method
        switch encoding {
        case .query:
            self.encoding = URLEncoding.queryString
        case .json:
            self.encoding = JSONEncoding.default
        case .none:
            self.encoding = URLEncoding.default
            
        }
    }
    
    var url: URL {
        URL(string: route)!
    }
}

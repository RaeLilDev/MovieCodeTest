//
//  BaseResponse.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    var data: T?
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "results"
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

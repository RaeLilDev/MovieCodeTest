//
//  ApiConstants.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation

class ApiConstants {
    static var baseUrl: String {
        let base = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        return base
    }
    
    static var accessToken: String {
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String ?? ""
        return accessToken
    }
    
    static let version: String = "3"
}

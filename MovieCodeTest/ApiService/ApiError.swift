//
//  ApiError.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation

/// Handle all error case while fetching network data.
enum ApiError: Error {
    /// occurs when connection is interrupted
    case noConnection
    /// occurs when  acccount is logged in from another device and fetch network data from old devlce.
    case sessionExpired
    /// decoding does not match from API response
    case decodingError(Int)
    /// occurs when something went wrong on backend side
    case serverError(String)
    /// occurs when request is taking too long
    case requestTimeOut
    /// network request has been cancelled.
    case requestCancel
    
    /// return string value that covered all ``ApiError`` cases.
    var description: String {
        switch self {
        case .noConnection:
            return "No Connection."
        case .sessionExpired:
            return "Session Expired."
        case .decodingError(let code):
            return "StatusCode: \(code) - An error occurs in decoding."
        case .serverError(let code):
            return "StatusCode: \(code) - Something went wrong."
        case .requestTimeOut:
            return "You have an unstable network at the moment, please try again when network stabilizes."
        case .requestCancel:
            return "Request has been cancelled."
        }
    }

}

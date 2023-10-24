//
//  BaseModel.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import Alamofire

class BaseModel {
    
    let service = ApiService.shared
    
    deinit {
        print("Deinit: - " + String(describing: self))
    }
}

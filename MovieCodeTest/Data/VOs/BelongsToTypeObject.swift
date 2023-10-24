//
//  BelongsToTypeObject.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RealmSwift

class BelongsToTypeObject: Object {
    
    @Persisted(primaryKey: true)
    var name: String
    
    @Persisted(originProperty: "belongsToType")
    var movies: LinkingObjects<MovieVO>
    
}

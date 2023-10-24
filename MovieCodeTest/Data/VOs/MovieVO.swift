//
//  MovieVO.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RealmSwift

class MovieVO: Object {
    
    @Persisted
    var adult: Bool?
    
    @Persisted
    var backdropPath: String?
    
    @Persisted
    var genreIDS = List<Int>()
    
    @Persisted(primaryKey: true)
    var id: Int?
    
    @Persisted
    var originalLanguage: String?
    
    @Persisted
    var originalTitle: String?
    
    @Persisted
    var overview: String?
    
    @Persisted
    var popularity: Double?
    
    @Persisted
    var posterPath: String?
    
    @Persisted
    var releaseDate: String?
    
    @Persisted
    var title: String?
    
    @Persisted
    var video: Bool?
    
    @Persisted
    var voteAverage: Double?
    
    @Persisted
    var voteCount: Int?
    
    @Persisted
    var belongsToType: List<BelongsToTypeObject>
    
    @Persisted
    var favorite: Bool?
    
    
    func toUpdateParams() -> [String: Any] {
        return [
            "adult": self.adult ?? "",
            "backdropPath": self.backdropPath ?? "",
            "genreIDS": self.genreIDS ,
            "id": self.id ?? 0,
            "originalLanguage": self.originalLanguage ?? "",
            "originalTitle": self.originalTitle ?? "",
            "overview": self.overview ?? "",
            "popularity": self.popularity ?? 0.0,
            "posterPath": self.posterPath ?? "",
            "releaseDate": self.releaseDate ?? "",
            "title": self.title ?? "",
            "video": self.video ?? "",
            "voteAverage": self.voteAverage ?? 0.0,
            "voteCount": self.voteCount ?? 0,
            "belongsToType": self.belongsToType
        ]
    }
    
}

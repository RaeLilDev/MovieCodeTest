//
//  Movie.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RealmSwift

struct Movie: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func toMovieVO(groupType: BelongsToTypeObject) -> MovieVO {
        let object = MovieVO()
        object.id = self.id
        object.adult = self.adult
        object.backdropPath = self.backdropPath
        object.genreIDS.append(objectsIn: self.genreIDS ?? [])
        object.originalLanguage = self.originalLanguage
        object.originalTitle = self.originalTitle
        object.overview = self.overview
        object.popularity = self.popularity
        object.posterPath = self.posterPath
        object.releaseDate = self.releaseDate
        object.title = self.title
        object.video = self.video
        object.voteAverage = self.voteAverage
        object.voteCount = self.voteCount
        object.belongsToType.append(groupType)
        return object
    }
    
}

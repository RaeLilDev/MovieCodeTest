//
//  MovieRepository.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RealmSwift
import RxSwift

protocol MovieRepository {
    
    func saveList(data: [MovieVO])
    
    func getList(type: BelongsToTypeObject) -> Observable<[MovieVO]>
    
    func getDetail(id: Int) -> Observable<MovieVO>
    
    func updateFav(for id: Int)
    
}

class MovieRepositoryImpl: BaseRepository, MovieRepository {
    
    static let shared: MovieRepository = MovieRepositoryImpl()
    
    private let contentTypeRepo: ContentTypeRepository = ContentTypeRepositoryImpl.shared
    
    private override init() { }
    
    func saveList(data: [MovieVO]) {
        data.forEach { movie in
            if let object = realmInstance.db.object(ofType: MovieVO.self, forPrimaryKey: movie.id ?? -1) {
                try! realmInstance.db.write {
                    realmInstance.db.create(MovieVO.self, value: movie.toUpdateParams(),update: .modified)
                }
            } else {
                try! realmInstance.db.write {
                    realmInstance.db.add(movie, update: .modified)
                }
            }
        }
    }
    
    func getList(type: BelongsToTypeObject) -> Observable<[MovieVO]> {
        let items = realmInstance.db.objects(MovieVO.self).filter("ANY belongsToType == %@", type)
        return Observable.array(from: items)
    }
    
    func getDetail(id: Int) -> Observable<MovieVO> {
        let items = realmInstance.db.objects(MovieVO.self).filter("id == %@", id)
        let movie = Array(items).first!
        return Observable.from(object: movie)
    }
    
    func updateFav(for id: Int) {
        if let movie = realmInstance.db.object(ofType: MovieVO.self, forPrimaryKey: id) {
            try! realmInstance.db.write {
                movie.favorite = !(movie.favorite ?? false)
            }
        }
    }
    
}

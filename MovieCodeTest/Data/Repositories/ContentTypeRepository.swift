//
//  ContentTypeRepository.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RxSwift
import RxRealm

protocol ContentTypeRepository {
    
//    func getPopularOrUpcoming(type: MovieType, completion: @escaping ([MovieVO]) -> Void)
    
    func getPopularOrUpcoming(type: MovieType) -> Observable<[MovieVO]>
    
    func getBelongsToTypeObject(type: MovieType) -> BelongsToTypeObject
    
    func save(name: String) -> BelongsToTypeObject
    
}

class ContentTypeRepositoryImpl: BaseRepository, ContentTypeRepository {
    
    static let shared: ContentTypeRepository = ContentTypeRepositoryImpl()
    
    private var contentTypeMap = [String: BelongsToTypeObject]()
    
    private override init() {
        super.init()
        
        initializeData()
    }
    
    private func initializeData() {
        
        let dataSource = realmInstance.db.objects(BelongsToTypeObject.self)
                
        if dataSource.isEmpty {
            MovieType.allCases.forEach {
                let _ = save(name: $0.rawValue)
            }
        } else {
            dataSource.forEach {
                contentTypeMap[$0.name] = $0
            }
        }
        
    }
    
//    func getPopularOrUpcoming(type: MovieType) -> Observable<[MovieVO]> {
//        if let object = contentTypeMap[type.rawValue] {
//            let items:[MovieVO] = object.movies.map { $0 }
//            return Observable.array(from: items)
//        } else {
//            return Observable.array(from: [MovieVO]())
//        }
//    }
    
    func getPopularOrUpcoming(type: MovieType) -> Observable<[MovieVO]> {
        return Observable.create { observer in
            if let object = self.contentTypeMap[type.rawValue] {
                let items: [MovieVO] = object.movies.map { $0 }
                observer.onNext(items)
                observer.onCompleted()
            } else {
                observer.onNext([])
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func getBelongsToTypeObject(type: MovieType) -> BelongsToTypeObject {
        if let object = contentTypeMap[type.rawValue] {
            return object
        }
        return save(name: type.rawValue)
    }
    
    func save(name: String) -> BelongsToTypeObject {
        
        let object = BelongsToTypeObject()
        object.name = name
        contentTypeMap[name] = object
        
        try! realmInstance.db.write {
            realmInstance.db.add(object, update: .modified)
        }
        
        return object
    }
    
}

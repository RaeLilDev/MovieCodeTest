//
//  MovieModel.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RxSwift

protocol MovieModel {
    
    func fetchPopularMovies(page: Int) -> Observable<[MovieVO]>
    
    func fetchUpcomingMovies(page: Int) -> Observable<[MovieVO]>
    
    func fetchMovieDetail(by id: Int) -> Observable<MovieVO>
    
    func updateFav(for id: Int)
    
}

class MovieModelImpl: BaseModel, MovieModel {
    
    static let shared = MovieModelImpl()
    
    private let movieRepository: MovieRepository = MovieRepositoryImpl.shared
    private let contentTypeRepository: ContentTypeRepository = ContentTypeRepositoryImpl.shared
    
    private let disposeBag = DisposeBag()
    
    private override init() {}
    
    func fetchPopularMovies(page: Int) -> Observable<[MovieVO]> {
        let contentType: MovieType = .popularMovies
        service.request(endpoint: .popularMovies(page), response: BaseResponse<[Movie]>.self).subscribe(onNext: {[weak self] response in
            guard let self = self else { return }
            
            let data: [Movie] = response.data ?? []
            let remoteMovies = data.map { $0.toMovieVO(groupType: self.contentTypeRepository.getBelongsToTypeObject(type: contentType)) }
            
            movieRepository.saveList(data: remoteMovies)
            
        }).disposed(by: disposeBag)
        return movieRepository.getList(type: self.contentTypeRepository.getBelongsToTypeObject(type: contentType))
    }
    
    func fetchUpcomingMovies(page: Int) -> Observable<[MovieVO]> {
        let contentType: MovieType = .upcomingMovies
        service.request(endpoint: .upcomingMovies(page), response: BaseResponse<[Movie]>.self).subscribe(onNext: {[weak self] response in
            guard let self = self else { return }
            
            let data: [Movie] = response.data ?? []
            let remoteMovies = data.map { $0.toMovieVO(groupType: self.contentTypeRepository.getBelongsToTypeObject(type: contentType)) }
            
            movieRepository.saveList(data: remoteMovies)
            
        }).disposed(by: disposeBag)
        return movieRepository.getList(type: self.contentTypeRepository.getBelongsToTypeObject(type: contentType))
    }
    
    func fetchMovieDetail(by id: Int) -> Observable<MovieVO> {
        return movieRepository.getDetail(id: id)
    }
    
    func updateFav(for id: Int) {
        movieRepository.updateFav(for: id)
    }
    
}

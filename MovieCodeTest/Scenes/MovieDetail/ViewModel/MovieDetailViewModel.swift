//
//  MovieDetailViewModel.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    
    private var movieModel: MovieModel!
    private var movieId: Int!
    private let disposeBag = DisposeBag()
    
    var movie = BehaviorRelay<MovieVO?>(value: nil)
    
    init(movieId: Int, movieModel: MovieModel) {
        self.movieId = movieId
        self.movieModel = movieModel
    }
    
    func getMovieDetail() {
        movieModel.fetchMovieDetail(by: movieId).subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            self.movie.accept(data)
        }).disposed(by: disposeBag)
    }
    
    func updateFav() {
        movieModel.updateFav(for: movieId)
    }
}

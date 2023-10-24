//
//  HomeViewModel.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    private var movieModel: MovieModel!
    
    var homeItemList = BehaviorRelay<[HomeSection]>(value: [])
    
    private var popularList = BehaviorRelay<[MovieVO]>(value: [])
    private var upcomingList = BehaviorRelay<[MovieVO]>(value: [])
    
    private var currentPage = 1
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
    
    func initObservers() {
        Observable.combineLatest(popularList, upcomingList)
            .debounce(.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe{ [weak self] popularMovies, upcomingMovies in
                guard let self = self else { return }
                var items = [HomeSection]()
                if !popularMovies.isEmpty {
                    items.append(.movieList(title: "Popular Movies", movies: popularMovies))
                }
                if !upcomingMovies.isEmpty {
                    items.append(.movieList(title: "Upcoming Movies", movies: upcomingMovies))
                }
                self.homeItemList.accept(items)
            }.disposed(by: disposeBag)
    }
    
    func fetchAllData() {
        fetchPopularMovies()
        fetchUpcomingMovies()
    }
    
    private func fetchPopularMovies() {
        movieModel.fetchPopularMovies(page: currentPage).subscribe(onNext: {[weak self] response in
            guard let self = self else { return }
            self.popularList.accept(response)
        }).disposed(by: disposeBag)
    }
    
    private func fetchUpcomingMovies() {
        movieModel.fetchUpcomingMovies(page: currentPage).subscribe(onNext: {[weak self] response in
            guard let self = self else { return }
            self.upcomingList.accept(response)
        }).disposed(by: disposeBag)
    }
    
    func updateFav(for movie: MovieVO) {
        movieModel.updateFav(for: movie.id ?? -1)
    }
    
    func getSectionCount() -> Int {
        return homeItemList.value.count
    }
    
    func getRowCount() -> Int {
        return homeItemList.value.count
    }
    
    func getItem(by index: Int) -> HomeSection {
        return homeItemList.value[index]
    }
    
}

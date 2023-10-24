//
//  HomeVC.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController {

    @IBOutlet weak var tableViewMovies: UITableView!
    
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupTableView()
        viewModel.fetchAllData()
        viewModel.initObservers()
        bindData()
    }
    
    private func setupNavbar() {
        self.navigationItem.title = "Movie List"
    }
    
    private func setupTableView() {
        tableViewMovies.dataSource = self
        tableViewMovies.registerCell(from: MovieListCell.self)
    }
    
    private func bindData() {
        viewModel.homeItemList.subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            self.tableViewMovies.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func presentMovieDetail(with movie: MovieVO) {
        let vc = MovieDetailVC()
        vc.viewModel = MovieDetailViewModel(movieId: movie.id ?? -1, movieModel: MovieModelImpl.shared)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.getItem(by: indexPath.row)
        switch item {
        case .movieList(let title, let movies):
            let cell = tableViewMovies.dequeueCell(from: MovieListCell.self, at: indexPath)
            cell.bind(title: title, with: movies)
            cell.didSelectMovie = {[weak self] movie in
                guard let self = self else { return }
                self.presentMovieDetail(with: movie)
            }
            cell.didSelectFav = {[weak self] movie in
                guard let self = self else { return }
                self.viewModel.updateFav(for: movie)
            }
            return cell
        }
    }
    
    
}

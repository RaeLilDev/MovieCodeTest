//
//  MovieListCell.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import UIKit

class MovieListCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    
    var movies = [MovieVO]()
    
    var didSelectMovie: ((MovieVO)->Void)?
    var didSelectFav: ((MovieVO)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }

    func bind(title: String, with movies: [MovieVO]) {
        lblTitle.text = title
        self.movies = movies
        collectionViewMovies.reloadData()
    }
    
    private func setupCollectionView() {
        collectionViewMovies.dataSource = self
        collectionViewMovies.delegate = self
        collectionViewMovies.registerCell(from: MovieItemCell.self)
    }
    
}

extension MovieListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(from: MovieItemCell.self, at: indexPath)
        cell.data = movies[indexPath.row]
        cell.didTapFav = {[weak self] in
            guard let self = self else { return }
            self.didSelectFav?(movies[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectMovie?(movies[indexPath.row])
    }
}

extension MovieListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 280)
    }
}

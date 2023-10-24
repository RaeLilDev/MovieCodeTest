//
//  MovieDetailVC.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var viewFav: UIStackView!
    @IBOutlet weak var ivFav: UIImageView!

    var viewModel: MovieDetailViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupGestureRecognizers()
        viewModel.getMovieDetail()
        bindData()
    }
    
    private func setupView() {
        self.navigationItem.title = "Movie Detail"
        viewFav.layer.cornerRadius = 8.0
    }
    
    private func setupGestureRecognizers() {
        let tapFav = UITapGestureRecognizer(target: self, action: #selector(onTapFav))
        viewFav.isUserInteractionEnabled = true
        viewFav.addGestureRecognizer(tapFav)
    }
    
    private func bindData() {
        viewModel.movie.subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            self.ivPoster.setWebImage(with: data?.posterPath)
            self.lblTitle.text = data?.originalTitle
            self.lblDesc.text = data?.overview
            self.ivFav.image = (data?.favorite ?? false) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        }).disposed(by: disposeBag)
    }
    
    @objc private func onTapFav() {
        viewModel.updateFav()
    }

}

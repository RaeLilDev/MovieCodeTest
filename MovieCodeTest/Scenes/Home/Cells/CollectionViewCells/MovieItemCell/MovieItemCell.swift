//
//  MovieItemCell.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import UIKit

class MovieItemCell: UICollectionViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewFav: UIStackView!
    @IBOutlet weak var ivFav: UIImageView!
    
    var data: MovieVO? {
        didSet {
            if let data = data {
                lblTitle.text = data.title
                ivPoster.setWebImage(with: data.posterPath)
                ivFav.image = (data.favorite ?? false) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            }
        }
    }
    
    var didTapFav: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewFav.layer.cornerRadius = 8.0
        
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let tapFav = UITapGestureRecognizer(target: self, action: #selector(onTapFav))
        viewFav.isUserInteractionEnabled = true
        viewFav.addGestureRecognizer(tapFav)
    }
    
    @objc private func onTapFav() {
        self.didTapFav?()
    }

}

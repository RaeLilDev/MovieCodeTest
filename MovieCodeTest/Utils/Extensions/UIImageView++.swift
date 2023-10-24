//
//  UIImageView++.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setWebImage(with urlString: String?) {
        guard let urlString = urlString else { return }
        let options: KingfisherOptionsInfo = [
            .transition(ImageTransition.fade(0.2)),
            .forceTransition,
            .cacheOriginalImage
        ]
        kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + urlString), placeholder: nil, options: options, completionHandler: nil)
    }
}

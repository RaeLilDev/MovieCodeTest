//
//  UITableView++.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(from type: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCell<T: UITableViewCell>(from type: T.Type, at indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}

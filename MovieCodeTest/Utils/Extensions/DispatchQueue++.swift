//
//  DispatchQueue++.swift
//  MovieCodeTest
//
//  Created by Ye linn htet on 10/23/23.
//

import Foundation

extension DispatchQueue {
    static var background: DispatchQueue {
        DispatchQueue.global(qos: .background)
    }
}

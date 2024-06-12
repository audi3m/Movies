//
//  Ex.swift
//  Movies
//
//  Created by J Oh on 6/11/24.
//

import UIKit

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension UICollectionViewCell {
    static var id: String {
        String(describing: self)
    }
}

extension UIImage {
    static let movie = UIImage(systemName: "movieclapper")
    static let arrowUp = UIImage(systemName: "arrow.up.circle")
}

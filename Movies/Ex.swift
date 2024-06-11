//
//  Ex.swift
//  Movies
//
//  Created by J Oh on 6/11/24.
//

import Foundation

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

//
//  FavoritesService.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 15.03.2023.
//

import Foundation

private extension String {
    static let favoritesKey = "favoritesKey"
}

final class FavoritesService {

    private let userDefaults: UserDefaults = .standard
    private(set) var favorites: Set<String> {
        get {
            Set(userDefaults.object(forKey: .favoritesKey) as? [String] ?? [])
        }
        set {
            userDefaults.set(Array(newValue), forKey: .favoritesKey)
        }
    }

    func updateFavorites(with key: String) {
        favorites.formSymmetricDifference([key])
    }
}

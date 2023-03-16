//
//  QuotesRepo.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

private extension String {

    static let favoritesKey = "favoritesKey"
}

final class QuotesRepo {

    private let networkService: NetworkService
    private let userDefaults: UserDefaults = .standard
    private(set) var quotes: [Quote] = []
    private(set) var favorites: Set<String> {
        get {
            Set(userDefaults.object(forKey: .favoritesKey) as? [String] ?? [])
        }
        set {
            userDefaults.set(Array(newValue), forKey: .favoritesKey)
        }
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchQuotes() async throws {
        do {
            let data = try await networkService.performRequest(.getQuotesRequest)
            quotes = try JSONDecoder().decode([Quote].self, from: data)
        } catch {
            throw error
        }
    }

    func updateFavorites(with key: String) {
        favorites.formSymmetricDifference([key])
    }
}

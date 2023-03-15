//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

class DataManager {

    private let networkService: NetworkService
    init(networkService: NetworkService, favoritesService: FavoritesService = .init()) {
        self.networkService = networkService
    }

    func fetchQuotes() async throws -> [Quote] {
        do {
            let data = try await networkService.performRequest(.getQuotesRequest)
            let quotes = try JSONDecoder().decode([Quote].self, from: data)

            return quotes
        } catch {
            throw error
        }
    }
}

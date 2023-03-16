//
//  Market.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 30.04.21.
//

import Foundation

final class Market {

    let name: String = "SMI"
    var quotes: [Quote] = []
    var favoriteQuotesKeys: Set<String> = []

    func isFavorite(_ quote: Quote) -> Bool {
        favoriteQuotesKeys.contains(quote.key)
    }
}

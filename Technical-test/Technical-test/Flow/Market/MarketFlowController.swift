//
//  MarketFlowController.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 14.03.2023.
//

import UIKit

final class MarketFlowController: UIViewController {

    private let dataManager: DataManager
    private let navController = UINavigationController()
    private let favoritesService: FavoritesService
    private var market: Market?

    init(networkService: NetworkService = .init(), favoritesService: FavoritesService = .init()) {
        dataManager = DataManager(networkService: networkService)
        self.favoritesService = favoritesService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension MarketFlowController {

    func setup() {
        view.backgroundColor = .white
        addChildController(navController, to: view)
        navController.navigationBar.prefersLargeTitles = true

        Task {
            let market = await loadData()
            self.market = market
            let quotesListViewController = makeQuoteListViewController(for: market)
            navController.setViewControllers([quotesListViewController], animated: false)
        }
    }

    func loadData() async -> Market {
        let market = Market()
        do {
            let quotes = try await dataManager.fetchQuotes()
            market.quotes = quotes
            market.favoriteQuotesKeys = favoritesService.favorites
        } catch {
            showAlert(message: error.localizedDescription)
        }

        return market
    }

    func updateFavorites(with quote: Quote) {
        favoritesService.updateFavorites(with: quote.key)
    }

    func makeQuoteListViewController(for market: Market) -> QuotesListViewController {
        let vc = QuotesListViewController(market: market)
        vc.didSelectQuote = { [weak self] quote in
            self?.navigateToQuoteDetailsViewController(quote)
        }

        return vc
    }

    func navigateToQuoteDetailsViewController(_ quote: Quote) {
        let vc = QuoteDetailsViewController(quote: quote)
        vc.onAddToFavorites = { [weak self] in
            self?.handleAddToFavoritesAction(quote)
        }
        
        navController.pushViewController(vc, animated: true)
    }

    func handleAddToFavoritesAction(_ quote: Quote) {
        favoritesService.updateFavorites(with: quote.key)
        market?.favoriteQuotesKeys = favoritesService.favorites
        navController.popViewController(animated: true)
    }
}

//
//  MarketFlowController.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 14.03.2023.
//

import UIKit

final class MarketFlowController: UIViewController {

    private let embeddedNavigationController = UINavigationController()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)

    private let dataManager: DataManager
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

private extension MarketFlowController {

    func setup() {
        view.backgroundColor = .white
        addChild(embeddedNavigationController, to: view)
        embeddedNavigationController.navigationBar.prefersLargeTitles = true
        setupActivityIndicator()

        Task {
            await reload()
        }
    }

    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func reload() async {
        do {
            activityIndicator.startAnimating()
            let market = try await prepareMarket()
            activityIndicator.stopAnimating()

            showQuotesList(for: market)
        } catch {
            presentAlert(message: error.localizedDescription)
        }
    }

    func prepareMarket() async throws -> Market {
        let market = Market()
        do {
            let quotes = try await dataManager.fetchQuotes()
            market.quotes = quotes
            market.favoriteQuotesKeys = favoritesService.favorites
        } catch {
            throw error
        }

        return market
    }

    func showQuotesList(for market: Market) {
        self.market = market
        let quotesListViewController = makeQuoteListViewController(for: market)
        embeddedNavigationController.setViewControllers([quotesListViewController], animated: false)
    }

    func makeQuoteListViewController(for market: Market) -> QuotesListViewController {
        let viewController = QuotesListViewController(market: market)
        viewController.didSelectQuote = { [weak self] quote in
            self?.showQuote(quote)
        }

        return viewController
    }

    func showQuote(_ quote: Quote) {
        let viewController = QuoteDetailsViewController(quote: quote)
        viewController.onAddToFavorites = { [weak self] in
            self?.didAddToFavorites(quote)
        }
        
        embeddedNavigationController.pushViewController(viewController, animated: true)
    }

    func didAddToFavorites(_ quote: Quote) {
        favoritesService.updateFavorites(with: quote.key)
        market?.favoriteQuotesKeys = favoritesService.favorites
        embeddedNavigationController.popViewController(animated: true)
    }
}

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

    init(networkService: NetworkService = .init()) {
        dataManager = DataManager(networkService: networkService)

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
            let quotesListViewController = makeQuoteListViewController(for: market)
            navController.setViewControllers([quotesListViewController], animated: false)
        }
    }

    func loadData() async -> Market {
        let market = Market()
        do {
            let quotes = try await dataManager.fetchQuotes()
            market.quotes = quotes
        } catch {
            showAlert(message: error.localizedDescription)
        }

        return market
    }

    func makeQuoteListViewController(for market: Market) -> QuotesListViewController {
        let vc = QuotesListViewController(market: market)

        return vc
    }
}

//
//  MarketFlowController.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 14.03.2023.
//

import UIKit

final class MarketFlowController: UIViewController {

    private let navController = UINavigationController()
    private lazy var quotesListViewController = makeQuoteListViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension MarketFlowController {

    func setup() {
        addChildController(navController, to: view)
        navController.setViewControllers([quotesListViewController], animated: false)
        navController.navigationBar.prefersLargeTitles = true
    }

    func makeQuoteListViewController() -> QuotesListViewController {
        let vc = QuotesListViewController()

        return vc
    }
}

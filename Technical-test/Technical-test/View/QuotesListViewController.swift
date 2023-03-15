//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuotesListViewController: UIViewController {
    
    private let dataManager: DataManager = DataManager(networkService: .init())
    private var market: Market? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        Task {
            do {
                let quotes = try await dataManager.fetchQuotes()
                print(quotes)
            } catch {
                print("🙂", error)
            }
        }
    }
    
}

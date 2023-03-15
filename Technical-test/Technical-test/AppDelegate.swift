//
//  AppDelegate.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var marketFlowController = MarketFlowController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = marketFlowController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}


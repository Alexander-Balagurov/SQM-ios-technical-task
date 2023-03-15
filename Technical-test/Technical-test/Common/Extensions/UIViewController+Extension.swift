//
//  UIViewController+Extension.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 15.03.2023.
//

import UIKit

private extension String {
    static let ok = "OK"
}

extension UIViewController {

    func addChildController(
        _ child: UIViewController,
        to container: UIView,
        fillContainer fill: Bool = true
    ) {
        addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: self)

        if fill {
            child.view.frame = self.view.bounds
        }
    }

    func removeChild(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

    func showAlert(title: String? = nil, message: String? = nil, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: .ok, style: .default, handler: { _ in
            action?()
        }))

        present(alert, animated: true)
    }
}

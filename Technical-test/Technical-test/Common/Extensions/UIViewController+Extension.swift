//
//  UIViewController+Extension.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 15.03.2023.
//

import UIKit

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
}

//
//  UITableView+Extension.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 15.03.2023.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: String(describing: type))
    }

    func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with \(identifier)")
        }
        return cell
    }
}

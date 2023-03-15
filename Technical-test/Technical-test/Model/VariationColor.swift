//
//  VariationColor.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 15.03.2023.
//

import UIKit

enum VariationColor: String {
    case red
    case green

    var asUIColor: UIColor {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        }
    }
}

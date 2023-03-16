//
//  URLRequest+Extension.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 14.03.2023.
//

import Foundation

private extension String {

    static let path = "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
}

extension URLRequest {

    static var getQuotesRequest: URLRequest {
        URLRequest(url: URL(string: .path)!)
    }
}

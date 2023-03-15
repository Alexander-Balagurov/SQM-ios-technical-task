//
//  NetworkService.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 14.03.2023.
//

import Foundation

class NetworkService {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func performRequest(_ urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, _) = try await session.data(for: urlRequest)

            return data
        } catch {
            throw error
        }
    }
}

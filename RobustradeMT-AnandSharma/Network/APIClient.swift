//
//  APIClient.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 03/01/26.
//

import Foundation

protocol APIServiceProtocol {
    func fetchProducts(
        page: Int,
        completion: @escaping (Result<ProductListResponse, NetworkError>) -> Void
    )
}

final class APIService: APIServiceProtocol {

    func fetchProducts(
        page: Int,
        completion: @escaping (Result<ProductListResponse, NetworkError>) -> Void
    ) {

        let urlString = "https://fakeapi.net/products?page=\(page)&limit=1&category=electronics"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in

            if error != nil {
                completion(.failure(.noInternet))
                return
            }

            guard let data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(ProductListResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
}

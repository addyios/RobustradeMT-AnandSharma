//
//  NetworkError.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 03/01/26.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case invalidResponse
    case decodingError
}

extension NetworkError {
    var message: String {
        switch self {
        case .noInternet:
            return "No internet connection. Please check your network and try again."
        case .invalidResponse:
            return "Something went wrong. Please try again later."
        case .decodingError:
            return "Unable to process data from server."
        }
    }
}

//
//  ProductResponse.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 03/01/26.
//

import Foundation


struct ProductListResponse: Codable {
    let data: [Product]
    let pagination: Pagination
}

struct Product: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let brand: String?
    let stock: Int?
    let image: String?
    let specs: [String: SpecValue]?
    let rating: Rating
}

struct Specs: Codable {
    let color: String?
    let weight: String?
    let storage: String?
    let battery: String?
    let waterproof: Bool?
    let screen: String?
    let ram: String?
    let capacity: String?
    let output: String?
    let connection: String?
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct Pagination: Codable {
    let page: Int
    let limit: Int
    let total: Int
}

enum SpecValue: Codable {
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else {
            throw DecodingError.typeMismatch(
                SpecValue.self,
                .init(codingPath: decoder.codingPath,
                      debugDescription: "Unsupported spec type")
            )
        }
    }

    func displayValue() -> String {
        switch self {
        case .string(let value):
            return value
        case .bool(let value):
            return value ? "Yes" : "No"
        case .int(let value):
            return "\(value)"
        case .double(let value):
            return "\(value)"
        }
    }
}
